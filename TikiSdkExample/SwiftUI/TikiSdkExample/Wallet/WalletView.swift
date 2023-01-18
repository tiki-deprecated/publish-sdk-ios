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
                    let tikiSdk = appModel.walletList[index]
                    let addr: String = tikiSdk.address!.prefix(16) + "..."
                    Button( addr + "..."){
                        print(addr)
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
                    let source: String = UUID().uuidString
                    appModel.stream = Stream(source: source)
        
                    appModel.walletList.append(tikiSdk)
                    if(appModel.selectedWalletIndex != 0){
                        appModel.selectedWalletIndex += 1
                    }
                    
                    let _ = try await appModel.tikiSdk!.assignOwnership(source: source, type: TikiSdkDataTypeEnum.stream, contains: ["generic data"], about: "Data stream created with TIKI SDK Sample App")
                    let ownership = try await appModel.tikiSdk?.getOwnership(source: source)
                    appModel.ownershipDictionary[tikiSdk.address!] = [ownership!]
                        
                    
                    let destination = TikiSdkDestination(paths: ["postman-echo.com/post"], uses: ["POST"])
                    let consent: TikiSdkConsent = try await tikiSdk.modifyConsent(ownershipId: ownership!.transactionId, destination: destination, about: "" , reward: "", expiry: Calendar.current.date(byAdding: DateComponents(year: 10), to: Date())!)
                    appModel.consentDictionary[ownership!.transactionId] = consent
                    
                    isLoading = false
                }catch{
                    print(error.localizedDescription, error)
                }
            }
        }
    }

}

