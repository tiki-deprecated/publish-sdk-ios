//
//  AddressView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import SwiftUI
import TikiSdk

struct ConsentApplyView: View {
    
    let tikiSdk: TikiSdk
    let ownershipId: String
    
    @State var tikiSdkConsent: TikiSdkConsent? = nil
    
    var body: some View {
        VStack{
            Text("Consent for")
            Text(ownershipId)
            if(tikiSdkConsent == nil){
                ProgressView()
            }else{
                HStack{
                    Text("OwnershipId")
                    Text(tikiSdkConsent!.ownershipId)
                }
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
                    Text(tikiSdkConsent!.destination.paths.joined(separator: "uses"))
                }
                HStack{
                    Text("About")
                    Text(tikiSdkConsent?.about ?? "no value")
                }
                HStack{
                    Text("Reward")
                    Text(tikiSdkConsent?.reward ?? "no value")
                }
            }
//            NavigationView{
//                List {
//                    ConsentModifyView(tikiSdkConsent)
//                    NavigationLink(destination: ContentView()) {
//                        Text("Modify consent")
//                    }
//                }
//            }
        }
    }
    

}

