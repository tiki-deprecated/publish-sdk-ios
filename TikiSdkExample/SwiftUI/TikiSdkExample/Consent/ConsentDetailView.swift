/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct ConsentDetailView: View {
    
    let tikiSdk: TikiSdk
    
    @Binding var tikiSdkConsent: TikiSdkConsent?
    @State var isShowingGiveConsent: Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            Text("Consent for")
            Text(tikiSdkConsent!.ownershipId.prefix(16) + "...")
            List{
                HStack{
                    Text("TransactionId")
                    Text(tikiSdkConsent!.transactionId.prefix(16) + "...")
                }
                Text("Destination")
                HStack{
                    Text("Paths: ")
                    Text(tikiSdkConsent!.destination.paths.joined(separator: ","))
                }
                HStack{
                    Text("Uses: ")
                    Text(tikiSdkConsent!.destination.uses.joined(separator: ","))
                }
                HStack{
                    Text("About")
                    Text(tikiSdkConsent!.about ?? "")
                }
                HStack{
                    Text("Reward")
                    Text(tikiSdkConsent!.reward ?? "")
                }
            }
            Button("Modify Consent") {
                isShowingGiveConsent.toggle()
            }.sheet(isPresented: $isShowingGiveConsent) {
                ConsentModifyView(tikiSdk: tikiSdk, consentNft: $tikiSdkConsent, isShowing: $isShowingGiveConsent)
            }
        }
    }
}

