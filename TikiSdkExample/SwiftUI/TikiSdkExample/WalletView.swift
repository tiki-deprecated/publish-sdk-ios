/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct WalletView: View {
    
    @Binding var wallets: [String]
    @Binding var tikiSdk: TikiSdk?
    @Binding var ownership: TikiSdkOwnership?
    @Binding var bodyData: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isLoading = false
    
    let origin = "com.mytiki.tiki_sdk_example"
    let publishingId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90"
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Wallets").fontWeight(.heavy)
                .font(.largeTitle).padding()
                .multilineTextAlignment(.leading)
            List {
                ForEach(0..<wallets.count, id: \.self) { index in
                    let addr: String = wallets[index].prefix(16) + "..."
                    Button((wallets[index] == tikiSdk!.address ? "✔️" : "") + addr + "..."){
                        switchTo(addr: wallets[index])
                    }.foregroundColor(.gray).font(.system(size: 14))
                }
                Button("+ new wallet") {
                    createWallet()
                }.disabled(isLoading).font(.system(size: 14))
            }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
        }.background(Color(.systemGray6))
    }
    
    func createWallet(){
        if(!isLoading){
            isLoading = true
            Task {
                do{
                    tikiSdk = try await TikiSdk(origin: origin, publishingId: publishingId)
                    wallets.append(tikiSdk!.address!)
                    let source = Data(bodyData.utf8).base64EncodedString()
                    let _ = try await tikiSdk!.assignOwnership(source: source, type: TikiSdkDataTypeEnum.stream, contains: ["generic data"], about: "Data stream created with TIKI SDK Sample App")
                    ownership = try await tikiSdk!.getOwnership(source: source)
                    isLoading = false
                    DispatchQueue.main.async {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }catch{
                    print(error.localizedDescription, error)
                }
            }
        }
    }

    func switchTo(addr: String){
        if(!isLoading){
            isLoading = true
            Task {
                do{
                    let source = Data(bodyData.utf8).base64EncodedString()
                    tikiSdk = try await TikiSdk(origin: origin, publishingId: publishingId, address: addr)
                    ownership = try await tikiSdk!.getOwnership(source: source)
                    isLoading = false
                    DispatchQueue.main.async {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }catch{
                    print(error.localizedDescription, error)
                }
            }
        }
    }
}

