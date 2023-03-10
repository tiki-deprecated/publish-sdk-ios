import SwiftUI

public struct OfferFlow: View{
    
    @State var route: Routes = Routes.none
    @State var sheet: Sheets = Sheets.prompt
    @State var activeOffer: Offer? = nil
    
    public init() {}
    
    public var body: some View{
        NavigationView{
            VStack{
                NavigationLink(destination: Terms(offer: TikiSdk.instance.offers.values.first, onDismiss: {
                    sheet = Sheets.prompt
                    route = Routes.none
                }, onAccept: { offer in
                    if(offer == nil){
                        sheet = Sheets.none
                        route = Routes.none
                    }else if(offer!.requiredPermissions.isEmpty){
                        sheet = Sheets.endingAccepted
                        route = Routes.none
                    }else{
                        sheet = Sheets.endingError
                        route = Routes.none
                        activeOffer = offer
                    }
                }), isActive: Binding(
                    get: {route == Routes.terms},
                    set: {let _ = $0}
                )){
                    EmptyView()
                }
                NavigationLink(destination: LearnMore(onDismiss: {
                    if(sheet != Sheets.prompt){
                        sheet = Sheets.prompt
                        route = Routes.none
                    }
                }), isActive: Binding(
                    get: {route == Routes.learnMore},
                    set: {let _ = $0}
                )){
                    EmptyView()
                }
                NavigationLink(destination: Settings(
                    onAccept: {offer in
                        route = Routes.terms
                        sheet = Sheets.none
                    },
                    onDecline: {offer in
                        sheet = TikiSdk.instance.isDeclineEndingDisabled ? Sheets.none : Sheets.endingDeclined
                    },
                    onLearnMore: {
                        route = Routes.learnMore
                    },
                    onDismiss: {
                        route = Routes.none
                        sheet = Sheets.none
                    }), isActive: Binding(
                        get: {route == Routes.settings},
                        set: {let _ = $0}
                    )){
                        EmptyView()
                    }
            }.sheet(isPresented: Binding(
                get: {sheet == Sheets.prompt},
                set: {let _ = $0}
            ), onDismiss: {
                if(sheet == Sheets.prompt){
                    sheet = Sheets.none
                }
            }) {
                OfferPrompt(offers: TikiSdk.instance.offers,
                            onAccept: {offer in
                    route = Routes.terms
                    sheet = Sheets.none
                },
                            onDecline: {offer in
                    sheet = TikiSdk.instance.isDeclineEndingDisabled ? Sheets.none : Sheets.endingDeclined
                },
                            onLearnMore: {
                    route = Routes.learnMore
                    sheet = Sheets.none
                })
            }
            .sheet(isPresented: Binding(
                get: {sheet == Sheets.endingAccepted},
                set: {let _ = $0}
            ), onDismiss: {
                sheet = Sheets.none
                
            }) {
                Ending(
                    title: Text("Your Choice"),
                    message: "Awesome! You’re in",
                    footnote: Text("We’re on it, stay tuned.\nChange your mind anytime in settings.")
                )
            }
            .sheet(isPresented: Binding(
                get: {sheet == Sheets.endingDeclined},
                set: {let _ = $0}
            ), onDismiss: {
                sheet = Sheets.none
                
            }) {
                Ending(
                    title: Text("Your Choice"),
                    message: "Backing Off",
                    footnote: Text("Your data is valuable.\nOpt-in anytime in settings.")
                )
            }
            .sheet(isPresented: Binding(
                get: {sheet == Sheets.endingError},
                set: {let _ = $0}
            ), onDismiss: {
                sheet = Sheets.prompt
            }) {
                Ending(
                    title: Text("Whoops"),
                    message: "Permission Required",
                    footnote: Text("Offer declined.\no proceed, allow \(activeOffer!.requiredPermissions.joined(separator: ", ")).")
                )
            }
        }
    }
}
