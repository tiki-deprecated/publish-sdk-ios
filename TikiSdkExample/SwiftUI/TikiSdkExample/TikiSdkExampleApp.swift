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
    }
}
