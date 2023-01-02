//
//  AddressView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import SwiftUI
import TikiSdk

struct ConsentDetailView: View {
    
    let tikiSdk: TikiSdk
    
    @Binding var tikiSdkConsent: TikiSdkConsent?
    @State var isShowingGiveConsent: Bool = false
    
    var body: some View {
        Text("Consent for")
        Text(tikiSdkConsent!.ownershipId)
        List{
            HStack{
                Text("TransactionId")
                Text(tikiSdkConsent!.transactionId)
            }
            Text("Destination")
            HStack{
                Text("Paths: ")
                Text(tikiSdkConsent!.destination.paths.joined(separator: ","))
            }
            HStack{
                Text("Uses: ")
                Text(tikiSdkConsent!.destination.paths.joined(separator: ","))
            }
            HStack{
                Text("About")
                Text(tikiSdkConsent!.about ?? "no value")
            }
            HStack{
                Text("Reward")
                Text(tikiSdkConsent!.reward ?? "no value")
            }
        }
        Button("Modify Consent") {
            isShowingGiveConsent.toggle()
        }.sheet(isPresented: $isShowingGiveConsent) {
            ConsentModifyView(tikiSdk: tikiSdk, ownershipId: tikiSdkConsent!.ownershipId, tikiSdkConsent: $tikiSdkConsent, isShowingGiveConsent: $isShowingGiveConsent)
        }
    }
    

}

