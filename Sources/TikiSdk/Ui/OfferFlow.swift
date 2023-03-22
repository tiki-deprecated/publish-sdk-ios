import SwiftUI

public struct OfferFlow: View{
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State var activeOffer: Offer
    @State var pendingPermissions: [Permission]? = nil
    @State var step: OfferFlowStep = .none
    @State var dragOffsetY: CGFloat = 0
    
    let offers: [String: Offer]
    
    var onSettings: (() -> Void)
    var onDismiss: (() -> Void)
    var onAccept: ((Offer, LicenseRecord) -> Void)?
    var onDecline: ((Offer, LicenseRecord?) -> Void)?
    
    public var body: some View{
        ZStack{
            if(step == .prompt){
                OfferPrompt(
                    currentOffer: $activeOffer,
                    offers: offers,
                    onAccept: { offer in
                        activeOffer = offer
                        pendingPermissions = offer.permissions
                        goTo(.terms)
                    },
                    onDecline: { offer in
                        decline(offer)
                        goTo(.endingDeclined)
                    },
                    onLearnMore: {goTo(.learnMore)}
                ).asBottomSheet(
                    isShowing: isShowingBinding(.prompt),
                    offset: $dragOffsetY,
                    onDismiss: dismissSheet)
                .transition(.bottomSheet).zIndex(2)
            }
            if(step == .endingAccepted){
                EndingAccepted(
                    onSettings: onSettings,
                    dismiss: dismissSheet
                ).asBottomSheet(
                    isShowing: isShowingBinding(.endingAccepted),
                    offset: $dragOffsetY,
                    onDismiss: dismissSheet)
                .transition(.bottomSheet)
            }
            if(step == .endingDeclined){
                EndingDeclined(
                    onSettings: onSettings,
                    dismiss: dismissSheet
                ).asBottomSheet(
                    isShowing: isShowingBinding(.endingAccepted),
                    offset: $dragOffsetY,
                    onDismiss: dismissSheet
                )
                .transition(.bottomSheet)
            }
            if(step == .endingError){
                EndingError(
                    pendingPermissions: $pendingPermissions,
                    onAuthorized: {
                        accept(activeOffer)
                        goTo(.endingAccepted)
                    }
                ).asBottomSheet(
                    isShowing: isShowingBinding(.endingAccepted),
                    offset: $dragOffsetY,
                    onDismiss: dismissSheet
                )
                .transition(.bottomSheet)
            }
            if(step == .terms){
                Terms(onAccept: onAcceptTerms, terms: activeOffer.terms!)
                    .asNavigationRoute(
                        isShowing: isShowingBinding(.terms),
                        title: "Terms and conditions",
                        onDismiss: {goTo(.prompt)}
                    )
                    .zIndex(1)
                    .transition(.navigate)
            }
            if(step == .learnMore){
                LearnMore()
                    .asNavigationRoute(
                        isShowing: isShowingBinding(.learnMore),
                        title: "LearnMore",
                        onDismiss: { goTo(.prompt) }
                    )
                    .zIndex(1)
                    .transition(.navigate)
            }
        }.onAppear{
            if(step == .none){
                withAnimation(.easeOut) {
                    step = .prompt
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 5, coordinateSpace: .global)
            .onChanged { value in
                if(step != .terms && step != .learnMore){
                    dragOffsetY = value.translation.height > 0 ? value.translation.height : 0
                }
            }
            .onEnded{ value in
                if(step != .terms && step != .learnMore){
                    withAnimation(.easeOut) {
                        step = .none
                    }
                    onDismiss()
                }
            }
        )
    }
    
    func goTo(_ step: OfferFlowStep){
        withAnimation(.easeOut){
            self.step = step
        }
    }
    
    func isShowingBinding(_ step: OfferFlowStep) -> Binding<Bool>{
        return Binding<Bool>(
            get: {
                self.step == step
            },
            set: { isShowing in
                withAnimation(.easeOut){
                    self.step = isShowing ? step : .none
                }
        })
    }
    
    func dismissSheet(){
        withAnimation(.easeOut){
            step = .none
        }
        onDismiss()
    }
    
    func onAcceptTerms(){
        if(isPendingPermission()){
            goTo(.endingError)
        }else{
            accept(activeOffer)
            goTo(.endingAccepted)
        }
    }
    
    func isPendingPermission() -> Bool{
        if(pendingPermissions == nil || pendingPermissions!.isEmpty){
            return false
        }else{
            var isPending = false
            pendingPermissions!.forEach{ permission in
                if(!permission.isAuthorized()){
                    isPending = true
                }
            }
            return isPending
        }
    }
    
    func accept(_ offer: Offer){
        Task{
            do{
                let license: LicenseRecord = try await license(offer: offer)
                onAccept?(offer, license)
                print(license)
                goTo(.endingAccepted)
            }catch{
                print(error)
            }
        }
    }
    
    func decline(_ offer: Offer){
        Task{
            onDecline?(offer, nil)
            goTo(.endingDeclined)
        }
    }
    
    func license(offer: Offer) async throws -> LicenseRecord {
        return try await TikiSdk.license( offer.ptr!, offer.uses, offer.terms!, tags: offer.tags, licenseDescription: offer.description,expiry: offer.expiry)
    }
    
}
