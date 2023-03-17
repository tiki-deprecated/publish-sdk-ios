import SwiftUI

public struct OfferFlow: View{
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State var route: Routes = Routes.none
    @State var sheet: Sheets = Sheets.none
    @State var activeOffer: Offer? = nil
    
    @State var dragOffsetY: CGFloat = 0
    
    var dismiss: (()->Void)? = nil
    
    public init(dismissAction: (()->Void)? = nil){
        self.dismiss = dismissAction
    }
    
    public var body: some View{
        ZStack{
            if(sheet == Sheets.prompt){
                BottomSheet(
                    isShowing: isShowingBinding(Sheets.endingAccepted),
                    offset: $dragOffsetY,
                    dismiss: {
                        withAnimation(.easeOut){
                            sheet = Sheets.none
                        }
                        dismiss?()
                    },
                    content: Sheets.prompt.view(
                        colorScheme,
                        onLearnMore: {
                            withAnimation(.easeOut){
                                route = Routes.learnMore
                            }
                        },
                        onAccept: { (offer, license) in
                            withAnimation(.easeOut){
                                activeOffer = offer
                                route = Routes.terms
                            }
                        },
                        onDecline: { (offer, license) in
                            withAnimation(.easeOut){
                                sheet = TikiSdk.instance.isDeclineEndingDisabled ? Sheets.none : Sheets.endingDeclined
                            }
                        })
                )
                .transition(.bottomSheet)
            }
            if(sheet == Sheets.endingAccepted){
                BottomSheet(
                    isShowing: isShowingBinding(Sheets.endingAccepted),
                    offset: $dragOffsetY,
                    dismiss: {
                        withAnimation(.easeOut){
                            sheet = Sheets.none
                        }
                        dismiss?()
                    },
                    content: Sheets.endingAccepted.view(colorScheme))
                .transition(.bottomSheet)
            }
            if(sheet == Sheets.endingDeclined){
                BottomSheet(
                    isShowing: isShowingBinding(Sheets.endingDeclined),
                    offset: $dragOffsetY,
                    dismiss: {
                        withAnimation(.easeOut){
                            sheet = Sheets.none
                        }
                        dismiss?()
                    },
                    content: Sheets.endingDeclined.view(colorScheme))
                .transition(.bottomSheet)
            }
            if(sheet == Sheets.endingError){
                BottomSheet(
                    isShowing: isShowingBinding(Sheets.endingError),
                    offset: $dragOffsetY,
                    dismiss: {
                        withAnimation(.easeOut){
                            sheet = Sheets.none
                        }
                        dismiss?()
                    },
                    content: Sheets.endingError.view(
                        colorScheme, requiredPermissions: activeOffer?.permissions))
                .transition(.bottomSheet)
            }
            if(route == Routes.terms){
                NavigationRoute(
                    isShowing: Binding(
                        get: {route == Routes.terms},
                        set: {let _ = $0}),
                    content: Routes.terms.view(offer: activeOffer, onAccept: {
                        withAnimation(.easeOut){
                            route = Routes.none
                        }
                        if(activeOffer != nil){
                            if(activeOffer!.permissions.isEmpty){
                                withAnimation(.easeOut){
                                    sheet = TikiSdk.instance.isAcceptEndingDisabled ?
                                    Sheets.none :
                                    Sheets.endingAccepted
                                }
                                
                            }else{
                                // TODO create License
                                withAnimation(.easeOut){
                                    route = Routes.none
                                }
                                activeOffer = nil
                                withAnimation(.easeOut){
                                    sheet = Sheets.endingError
                                }
                            }
                        }}, onDismiss: {
                            withAnimation(.easeOut){
                                route = Routes.none
                            }
                        }))
                .zIndex(1)
                .transition(.navigate)
            }
            if(route == .learnMore){
                NavigationRoute(
                    isShowing: Binding(
                        get: {route == Routes.learnMore},
                        set: {let _ = $0}
                    ),
                    content: Routes.learnMore.view(onDismiss: {
                        withAnimation(.easeOut){
                            route = Routes.none
                        }
                    }))
                .zIndex(1)
                .transition(.navigate)
            }
        }.onAppear{
            if(sheet == Sheets.none){
                withAnimation(.easeOut) {
                    sheet = Sheets.prompt
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 5, coordinateSpace: .global)
            .onChanged { value in
                if(route == Routes.none){
                    dragOffsetY = value.translation.height > 0 ? value.translation.height : 0
                }
            }
            .onEnded{ value in
                if(route == Routes.none){
                withAnimation(.easeOut) {
                        sheet = Sheets.none
                    }
                    dismiss?()
                }
            }
        )
    }
    
    func isShowingBinding(_ sheet: Sheets) -> Binding<Bool>{
        return Binding<Bool>(get: {
            self.sheet == sheet
        }, set: { show in
            self.sheet = show ? Sheets.prompt : Sheets.none
        })
    }
}

extension AnyTransition {
    static var navigate: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing))}
    
    
    static var bottomSheet: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .bottom))}
}
