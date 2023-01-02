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
    let tikiSdkConsent: TikiSdkConsent
    
    var body: some View {
        VStack{
            Text("Consent for")
            Text(tikiSdkConsent.ownershipId)
            HStack{
                Text("TransactionId")
                Text(tikiSdkConsent.transactionId)
            }
            Text("Destination")
            HStack{
                Text("Paths: ")
                Text(tikiSdkConsent.destination.paths.joined(separator: ","))
            }
            HStack{
                Text("Uses: ")
                Text(tikiSdkConsent.destination.paths.joined(separator: ","))
            }
            HStack{
                Text("About")
                Text(tikiSdkConsent.about ?? "no value")
            }
            HStack{
                Text("Reward")
                Text(tikiSdkConsent.reward ?? "no value")
            }
        }
    }
    

}

