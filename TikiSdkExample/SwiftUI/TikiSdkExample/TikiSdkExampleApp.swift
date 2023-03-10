/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    init() {
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
    
    @State var isLoading = false
    
    var body: some Scene {
        WindowGroup {
            VStack{
                Button("Start"){
                    isLoading = true
                }
            }.sheet(isPresented: $isLoading) {
                TikiSdk.present()
            }
        }
    }
    
    func startFlow(){
        print("start")
    }
    
}

private var starOverlay: some View {
    Image(systemName: "star")
        .foregroundColor(.white)
        .padding([.top, .trailing], 5)
}
