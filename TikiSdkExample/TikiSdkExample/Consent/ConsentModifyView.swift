//
//  AddressView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import SwiftUI
import TikiSdk

struct ConsentModifyView: View {
    
    let tikiSdk: TikiSdk
    let ownership: TikiSdkOwnership
    @Binding var isShowingGiveConsent: Bool
    
    @State var tikiSdkConsent: TikiSdkConsent? = nil
    @State var paths: String = ""
    @State var uses: String = ""
    @State var about: String = ""
    @State var reward: String = ""
    @State var expiry: Date = Date()
    @State var isConsentFetch = false
    
    var body: some View {
        Form{
            Section(header: Text("Destination")) {
                TextField("Paths", text: $paths)
                TextField("Uses", text: $uses)
            }
            TextField("About", text: $about)
            TextField("Reward", text: $reward)
            DatePicker(
                "Expiration",
                selection: $expiry,
                displayedComponents: [.date, .hourAndMinute]
            )
            Button("Modify Consent") {
                let destination = TikiSdkDestination(paths: paths.split(separator: ",").map { String($0) }, uses: uses.split(separator: ",").map { String($0) })
                Task{
                    do{
                        tikiSdkConsent = try await tikiSdk.modifyConsent(ownershipId: ownership.transactionId, destination: destination, about: about, reward: reward, expiry: expiry)
                        isShowingGiveConsent = false
                    }catch{
                        print(error)
                    }
                }
            }
        }.onAppear{
            if(!isConsentFetch){
                Task{
                    do{
                    tikiSdkConsent = try await tikiSdk.getConsent(source: ownership.source)
                    if(tikiSdkConsent != nil){
                        paths = tikiSdkConsent!.destination.paths.joined(separator: ",")
                        uses = tikiSdkConsent!.destination.uses.joined(separator: ",")
                        about = tikiSdkConsent!.about != nil ? tikiSdkConsent!.about! : ""
                        reward = tikiSdkConsent!.reward != nil ? tikiSdkConsent!.reward! : ""
                        expiry = tikiSdkConsent!.expiry != nil ? Date(timeIntervalSince1970: TimeInterval(tikiSdkConsent!.expiry! / 1000)) : Calendar.current.date(byAdding: DateComponents(year: 10), to: Date())!
                    }
                    }catch{
                        print(error)
                    }
                }
                isConsentFetch.toggle()
            }
        }
    }
}
