/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct WalletView: View {
    
    @EnvironmentObject var appModel: TikiSdkExampleAppModel

    @State private var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Wallets").fontWeight(.heavy)
                .font(.largeTitle).padding()
                .multilineTextAlignment(.leading)
            List {
                ForEach(0..<appModel.walletList.count, id: \.self) { index in
                    let tikiSdk : TikiSdk = appModel.wallets[appModel.walletList[index]]!
                    let addr: String = tikiSdk.address!.prefix(16) + "..."
                    Button(addr + "..."){
                        switchTo(addr: tikiSdk.address!)
                    }
                }
                Button("+ new wallet") {
                    createWallet()
                }.disabled(isLoading)
            }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
        }.background(Color(.systemGray6))
    }
    
    func createWallet(){
        if(!isLoading){
            isLoading = true
            Task {
                do{
                    let origin = "com.mytiki.tiki_sdk_example"
                    let apiId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90"
                    let tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
                    appModel.walletList.append(tikiSdk.address!)
                    appModel.wallets[tikiSdk.address!] = tikiSdk
                    appModel.selectedWalletAddress = tikiSdk.address!
                    
                    let _ = try await appModel.tikiSdk!.assignOwnership(source: appModel.stream.source, type: TikiSdkDataTypeEnum.stream, contains: ["generic data"], about: "Data stream created with TIKI SDK Sample App")
                    let ownership = try await appModel.tikiSdk?.getOwnership(source: appModel.stream.source)
                    appModel.ownershipDictionary[tikiSdk.address!] = ownership!
                        
                    let path: String = URL(string:appModel.stream.url)!.host!
                    let use: String = appModel.stream.httpMethod
                    let destination = TikiSdkDestination(paths: [path], uses: [use])
                    let consent: TikiSdkConsent = try await appModel.tikiSdk!.modifyConsent(ownershipId: appModel.ownership!.transactionId, destination: destination, about: "Consent given to echo data in remote server", reward: "Test the SDK", expiry: Calendar.current.date(byAdding: DateComponents(year: 10), to: Date())!)
                    appModel.consentDictionary[ownership!.transactionId] = consent
                    appModel.isConsentGiven = true
                    isLoading = false
                }catch{
                    print(error.localizedDescription, error)
                }
            }
        }
    }

    func switchTo(addr: String){
        appModel.selectedWalletAddress = addr
    }
}

