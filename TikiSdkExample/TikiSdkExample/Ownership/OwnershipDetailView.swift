//
//  AddressView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import SwiftUI
import TikiSdk

struct OwnershipDetailView: View {
    
    let tikiSdk: TikiSdk
    let ownership: TikiSdkOwnership?
    
    @State var consent: TikiSdkConsent?
    @State var isShowingGiveConsent: Bool = false
    @State var isConsentFetch: Bool = false
    
    var body: some View {
        VStack{
            Text("Ownership")
            List{
                HStack{
                    Text("Transaction Id")
                    Text(ownership!.transactionId.prefix(16) + "...")
                }
                HStack{
                    Text("Source")
                    Text(ownership!.source)
                }
                HStack{
                    Text("Origin")
                    Text(ownership!.origin)
                }
                HStack{
                    Text("Type")
                    Text(ownership!.type.rawValue)
                }
                HStack{
                    Text("Contains")
                    Text(ownership!.contains.joined(separator: ","))
                }
                HStack{
                    Text("About")
                    Text(ownership!.about ?? "")
                }
                if(consent != nil){
                    NavigationLink(destination: ConsentDetailView(tikiSdk: tikiSdk, tikiSdkConsent: $consent)) {
                        Text("Consent")
                        Text(consent!.transactionId.prefix(16) + "...")
                    }
                }else{
                    Text("No Consent")
                }
            }
        }.onAppear(perform: {
            Task{
                do{
                    consent = try await tikiSdk.getConsent(source: ownership!.source)
                }catch{
                    print(error.localizedDescription,error)
                }
            }
        })
    }
}

