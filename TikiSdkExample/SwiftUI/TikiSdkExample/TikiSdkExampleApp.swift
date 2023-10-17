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
                }

            }) {
                Text("Start").font(.custom("SpaceGrotesk-Regular", size:20))
            }.padding(.bottom, 48)
            Button(action: {
                Task{
                    do{
                        try await initTikiSdk()
                    }catch{
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
                .initialize(
                    id: "user_123",
                    publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
                )
        let ptr = NSUUID().uuidString
        print(ptr)
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        print("title")
        print(title!.id)
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        print("license")
        print(license!.id)
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        print("payable")
        print(payable!.id)
        let receipt = try await TikiSdk.instance.trail.receipt.create(payableId: payable!.id, amount: "10")
        print("receipt")
        print(receipt!.id)
    }
}
