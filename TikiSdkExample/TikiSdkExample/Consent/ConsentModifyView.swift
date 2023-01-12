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
    
    @Binding var consentNft: TikiSdkConsent?
    @Binding var isShowingGiveConsent: Bool
    
    @State private var paths: String
    @State private var uses: String
    @State private var about: String
    @State private var reward: String
    @State private var expiry: Date
    
    init(tikiSdk: TikiSdk, consentNft: Binding<TikiSdkConsent?>, isShowing: Binding<Bool>){
        self.tikiSdk = tikiSdk
        self._consentNft = consentNft
        self._isShowingGiveConsent = isShowing
        self._paths = State(initialValue: _consentNft.wrappedValue!.destination.paths.joined(separator: ","))
        self._uses = State(initialValue: _consentNft.wrappedValue!.destination.uses.joined(separator: ","))
        self._about = State(initialValue: _consentNft.wrappedValue!.about != nil ? consentNft.wrappedValue!.about! : "")
        self._reward = State(initialValue: _consentNft.wrappedValue!.reward != nil ? consentNft.wrappedValue!.reward! : "")
        self._expiry = State(initialValue: _consentNft.wrappedValue!.expiry != nil ? Date(timeIntervalSince1970: TimeInterval(_consentNft.wrappedValue!.expiry! / 1000)) : Calendar.current.date(byAdding: DateComponents(year: 10), to: Date())!)
    }
    
    var body: some View {
        VStack(spacing: 0){
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
            }
            Button("Save") {
                let destination = TikiSdkDestination(paths: paths.split(separator: ",").map { String($0) }, uses: uses.split(separator: ",").map { String($0) })
                Task{
                    do{
                        consentNft = try await tikiSdk.modifyConsent(ownershipId: consentNft!.ownershipId, destination: destination, about: $about.wrappedValue, reward: $reward.wrappedValue, expiry: $expiry.wrappedValue)
                        isShowingGiveConsent = false
                    }catch{
                        print(error)
                    }
                }
            }
            Spacer().frame(height: 30)
            Button("Cancel") {
                isShowingGiveConsent = false
            }
        }
    }
}
