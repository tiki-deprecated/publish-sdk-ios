/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    @State var route: Routes
    @State var sheet: Sheets
    
    init() {
        self.route = Routes.none
        self.sheet = Sheets.none
        Task{
            let publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            try await TikiSdk.config()
                .offer
                .setId("test_offer")
                .setReward(Image("offerImage"))
                .addUsedBullet(UsedBullet(text: "Learn how our ads perform ", isUsed: true))
                .addUsedBullet(UsedBullet(text: "Reach you on other platforms", isUsed: false))
                .addUsedBullet(UsedBullet(text: "Sold to other companies", isUsed: false))
                .setPtr("test_offer")
                .setDescription("Trade your IDFA (kind of like a serial # for your phone) for a discount.")
                .setTerms("todo")
                .addUse(LicenseUse(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)]))
                .addTag(TitleTag(TitleTagEnum.advertisingData))
                .setExpiry(expiry: Date().addingTimeInterval(365 * 24 * 60 * 60))
                .addReqPermission(permission: "camera")
                .add()
                .setOnAccept { offer in print("accepted")}
                .setOnDecline { offer in print("decline")}
                .setOnSettings  { offer in print("settings") }
                .disableAcceptEnding(false)
                .disableDeclineEnding(true)
                .initialize(publishingId: publishingId)
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                VStack{
                    Button("Start"){
                        sheet = Sheets.prompt
                    }
                    Button("Settings"){
                        route = Routes.settings
                    }
                    NavigationLink(destination: Terms(onDismiss: {
                        if(sheet != Sheets.prompt){
                            sheet = Sheets.prompt
                            route = Routes.none
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
                    if(sheet == Sheets.prompt){
                        sheet = Sheets.none
                    }
                }) {
                    
                }
            }
        }
    }
}


enum Routes{
    case none,
         terms,
         learnMore,
         settings
}

enum Sheets{
    case none,
         prompt,
         endingAccepted,
         endingDeclined,
         endingError
}

struct LearnMore : View{
    
    @Environment(\.isPresented) var isPresented
    var onDismiss: (() -> Void)
    
    public var body: some View {
        Text("LearnMore").onChange(of: isPresented){ value in
            if(!value){
                onDismiss()
            }
        }
    }
}


struct Terms : View{
    
    @Environment(\.isPresented) var isPresented
    var onDismiss: (() -> Void)
    
    public var body: some View {
        Text("Terms").onChange(of: isPresented){ value in
            if(!value){
                onDismiss()
            }
        }
    }
}

struct Settings : View{
    var onAccept: ((Offer) -> Void)
    var onDecline: ((Offer) -> Void)
    var onLearnMore: (() -> Void)
    var onDismiss: (() -> Void)
    public var body: some View {
        Text("Terms")
    }
}


