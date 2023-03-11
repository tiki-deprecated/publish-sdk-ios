import SwiftUI

public struct OfferFlow: View{
    
    @State var route: Routes = Routes.none
    @State var sheet: Sheets = Sheets.prompt
    @State var activeOffer: Offer? = nil
    
    @State var dragOffsetY: CGFloat = 0
    
    public init() {}
    
    public var body: some View{
        ZStack{
            BottomSheet(isShowing: isShowingBinding(Sheets.prompt), offset: $dragOffsetY, content: Sheets.prompt.view(
                onLearnMore: {
                    print("learnmore")
                    route = Routes.learnMore
                },
                onAccept: { offer in
                    print("accept")
                    activeOffer = offer
                    route = Routes.terms
                },
                onDecline: { offer in
                    print("decline")
                    sheet = TikiSdk.instance.isAcceptEndingDisabled ? Sheets.none : Sheets.endingDeclined
                })
            ).zIndex(sheet == Sheets.prompt && route == Routes.none ? 1 : 0)
            BottomSheet(isShowing: isShowingBinding(Sheets.endingAccepted), offset: $dragOffsetY, content: Sheets.endingAccepted.view()).zIndex(sheet == Sheets.endingAccepted && route == Routes.none ? 1 : 0)
            BottomSheet(isShowing: isShowingBinding(Sheets.endingDeclined), offset: $dragOffsetY, content: Sheets.endingDeclined.view()).zIndex(sheet == Sheets.endingDeclined && route == Routes.none ? 1 : 0)
            BottomSheet(isShowing: isShowingBinding(Sheets.endingError), offset: $dragOffsetY, content: Sheets.endingError.view(requiredPermissions: activeOffer?.requiredPermissions)).zIndex(sheet == Sheets.endingError && route == Routes.none ? 1 : 0)
            NavigationRoute(isShowing: Binding(
                get: {route == Routes.terms},
                set: {let _ = $0}
            ), content: Routes.terms.view(offer: activeOffer, onAccept: {
                route = Routes.none
                if(activeOffer != nil){
                    if(activeOffer!.requiredPermissions.isEmpty){
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
        }.gesture(DragGesture(minimumDistance: 5, coordinateSpace: .global)
            .onChanged { value in
                if(route == Routes.none){
                    dragOffsetY = value.translation.height > 0 ? value.translation.height : 0
                }
            }
            .onEnded{ value in
                if(route == Routes.none){
                    if(dragOffsetY > 50) {
                        sheet = Sheets.none
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
