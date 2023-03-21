/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    @State var isShowingOfferPrompt = false
    
    init() {
        try? TikiSdk.config()
            .offer
                .id("test_offer")
                .ptr("test_offer")
                .reward("offerImage")
                .bullet(text: "Learn how our ads perform ", isUsed: true)
                .bullet(text: "Reach you on other platforms", isUsed: false)
                .bullet(text: "Sold to other companies", isUsed: false)
                .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                .permission(PermissionType.camera)
                .permission(PermissionType.contacts)
                .tag(TitleTag(TitleTagEnum.advertisingData))
                .description("Trade your IDFA (kind of like a serial # for your phone) for a discount.")
                .terms("terms")
                .duration(365 * 24 * 60 * 60)
                .add()
            .onAccept { offer, license in print("accepted")}
            .onDecline { offer, license in print("declined")}
            //.onSettings  { print("settings") }
            .disableAcceptEnding(false)
            .disableDeclineEnding(false)
            .initialize( publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88", id: "user_123")
       
    }
    
    var body: some Scene {
        WindowGroup {
            Button(action: {
                do{
                    try TikiSdk.present()
                }catch{
                    print(error)
                }
            }) {
                Text("Start").font(.custom("SpaceGrotesk-Regular", size:20))
            }.padding(.bottom, 48)
            Button(action: {
                do{
                    try TikiSdk.settings()
                }catch{
                    print(error)
                }
            }) {
                Text("Settings").font(.custom("SpaceGrotesk-Regular", size:20))
            }
        }
    }
}
