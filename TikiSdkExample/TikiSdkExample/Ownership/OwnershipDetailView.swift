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
    
    @State var consent: TikiSdkConsent? = nil
    @State var isShowingGiveConsent: Bool = false
    @State var isConsentFetch: Bool = false
    
    var body: some View {
        VStack{
            Text("Ownership")
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
            if(isConsentFetch){
                Text("Consent")
                Text(consent?.transactionId ?? "no consent")
                Button("Modify Consent") {
                    isShowingGiveConsent.toggle()
                }.sheet(isPresented: $isShowingGiveConsent) {
                    ConsentModifyView(tikiSdk: tikiSdk, ownership: ownership, isShowingGiveConsent: $isShowingGiveConsent)
                }
            }else{
                ProgressView()
            }
        }.onAppear{
            if(!isConsentFetch){
                Task{
                    consent = try await tikiSdk.getConsent(source: ownership.source)
                }
                isConsentFetch.toggle()
            }
        }
    }
}

