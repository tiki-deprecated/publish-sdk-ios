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
    let ownership: TikiSdkOwnership
    
    @State var consent: TikiSdkConsent?
    @State var isShowingGiveConsent: Bool = false
    @State var isConsentFetch: Bool = false
    
    var body: some View {
        Text("Ownership")
        List{
            HStack{
                Text("Transaction Id")
                Text(ownership.transactionId)
            }
            HStack{
                Text("Source")
                Text(ownership.source)
            }
            HStack{
                Text("Origin")
                Text(ownership.origin)
            }
            HStack{
                Text("Type")
                Text(ownership.type.rawValue)
            }
            HStack{
                Text("Contains")
                Text(ownership.contains.joined(separator: ","))
            }
            HStack{
                Text("About")
                Text(ownership.about ?? "")
            }
            if(consent != nil){
                NavigationLink(destination: ConsentDetailView(tikiSdk: tikiSdk, tikiSdkConsent: $consent)) {
                    Text("Consent")
                    Text(consent?.transactionId ?? "no consent")
                }
            }else{
                Button("Give Consent") {
                    isShowingGiveConsent.toggle()
                }.sheet(isPresented: $isShowingGiveConsent) {
                    ConsentModifyView(tikiSdk: tikiSdk, ownershipId: ownership.transactionId, tikiSdkConsent: $consent, isShowingGiveConsent: $isShowingGiveConsent)
                }
            }
        }
    }
}

