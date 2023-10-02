/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    @State var isShowingOfferPrompt = false
    
    var body: some Scene {
        WindowGroup {
            Button(action: {
                Task{
                    try? await initTikiSdk()
                    try? await TikiSdk.present()
                }

            }) {
                Text("Start").font(.custom("SpaceGrotesk-Regular", size:20))
            }.padding(.bottom, 48)
            Button(action: {
                Task{
                    do {
                        try TikiSdk.settings()
                    }catch{
                        try? await initTikiSdk()
                        print(error)
                    }
                }
            }) {
                Text("Settings").font(.custom("SpaceGrotesk-Regular", size:20))
            }
        }
    }
    
    func initTikiSdk() async throws {
            try await TikiSdk.config()
                .offer
                .id("test_offer")
                .ptr("test_offer")
                .reward("offerImage")
                .bullet(text: "Learn how our ads perform ", isUsed: true)
                .bullet(text: "Reach you on other platforms", isUsed: false)
                .bullet(text: "Sold to other companies", isUsed: false)
                .use(usecases: [Usecase(UsecaseCommon.support)])
                .permission(Permission.camera)
                .permission(Permission.contacts)
                .tag(.init(tag: .ADVERTISING_DATA))
                .description("Trade your IDFA (kind of like a serial # for your phone) for a discount.")
                .terms("terms")
                .duration(365 * 24 * 60 * 60)
                .add()
                .onAccept { offer, license in print("accepted")}
                .onDecline { offer, license in print("declined")}
                .disableAcceptEnding(false)
                .disableDeclineEnding(false)
                .initialize(
                    id: "user_123",
                    publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
                )
    }
}
