import SwiftUI

public struct OfferFlow: View{
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State var route: Routes = Routes.none
    @State var sheet: Sheets = Sheets.prompt
    @State var activeOffer: Offer? = nil
    
    @State var dragOffsetY: CGFloat = 0
    
    var dismiss: (()->Void)? = nil
    
    public init(dismissAction: (()->Void)? = nil){
        self.dismiss = dismissAction
    }
    
    public var body: some View{
            ZStack{
                BottomSheet(isShowing: isShowingBinding(Sheets.prompt), offset: $dragOffsetY, dismiss: dismiss!, content: Sheets.prompt.view(
                    colorScheme,
                    onLearnMore: {
                        route = Routes.learnMore
                    },
                    onAccept: { (offer, license) in
                        activeOffer = offer
                        route = Routes.terms
                    },
                    onDecline: { (offer, license) in
                        sheet = TikiSdk.instance.isAcceptEndingDisabled ? Sheets.none : Sheets.endingDeclined
                    })
                ).zIndex(sheet == Sheets.prompt && route == Routes.none ? 1 : 0)
                BottomSheet(isShowing: isShowingBinding(Sheets.endingAccepted), offset: $dragOffsetY, dismiss: dismiss!,  content: Sheets.endingAccepted.view(colorScheme)).zIndex(sheet == Sheets.endingAccepted && route == Routes.none ? 1 : 0)
                BottomSheet(isShowing: isShowingBinding(Sheets.endingDeclined), offset: $dragOffsetY, dismiss: dismiss!,  content: Sheets.endingDeclined.view(colorScheme)).zIndex(sheet == Sheets.endingDeclined && route == Routes.none ? 1 : 0)
                BottomSheet(isShowing: isShowingBinding(Sheets.endingError), offset: $dragOffsetY, dismiss: dismiss!,  content: Sheets.endingError.view(colorScheme,requiredPermissions: activeOffer?.permissions)).zIndex(sheet == Sheets.endingError && route == Routes.none ? 1 : 0)
                NavigationRoute(isShowing: Binding(
                    get: {route == Routes.terms},
                    set: {let _ = $0}
                ), content: Routes.terms.view(offer: activeOffer, onAccept: {
                    route = Routes.none
                    if(activeOffer != nil){
                        if(activeOffer!.permissions.isEmpty){
                            sheet = TikiSdk.instance.isAcceptEndingDisabled ?
                            Sheets.none :
                            Sheets.endingAccepted
                        }else{
                            // TODO create License
                            activeOffer = nil
                            route = Routes.none
                            sheet = Sheets.endingError
                        }
                    }}, onDismiss: {
                        route = Routes.none
                    }))
                NavigationRoute(isShowing: Binding(
                    get: {route == Routes.learnMore},
                    set: {let _ = $0}
                ), content: Routes.learnMore.view(onDismiss: {
                    route = Routes.none
                }))
            }
            .background(Color(.clear))
            .gesture(DragGesture(minimumDistance: 5, coordinateSpace: .global)
                .onChanged { value in
                    if(route == Routes.none){
                        dragOffsetY = value.translation.height > 0 ? value.translation.height : 0
                    }
                }
                .onEnded{ value in
                    if(route == Routes.none){
                        if(dragOffsetY > 50) {
                            sheet = Sheets.none
                            dismiss?()
                        }
                        dragOffsetY = 0
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
