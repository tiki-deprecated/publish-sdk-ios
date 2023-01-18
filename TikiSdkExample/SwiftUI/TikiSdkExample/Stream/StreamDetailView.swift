///*
// * Copyright (c) TIKI Inc.
// * MIT license. See LICENSE file in root directory.
// */
//
//import SwiftUI
//import TikiSdk
//
//struct StreamDetailView: View {
//    
//    var tikiSdk: TikiSdk
//    @State var stream: Stream
//    @State var log: [String] = []
//    @State var isConsentGiven = false
//    @State var ownership: TikiSdkOwnership?
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    
//    var body: some View {
//        VStack{
//            List {
//                ForEach(0..<log.count, id: \.self) { index in
//                    Text(log[log.count-index-1])
//                }
//            }
//            Button(isConsentGiven ? "Revoke Consent" : "GiveConsent") {
//                toggleConsent()
//            }
//            Spacer().frame(height: 30)
//            if(ownership != nil){
//                NavigationLink(destination: OwnershipDetailView(tikiSdk: tikiSdk, ownership: ownership)) {
//                    Text("Ownership NFT")
//                }
//            }
//        }.onReceive(timer) { _ in
//            sendDataToServer()
//        }.onAppear(perform: {
//            Task{
//                do{
//                    sendDataToServer()
//                    ownership = try await tikiSdk.getOwnership(source: stream.source)!
//                }catch{
//                    print(error)
//                }
//            }
//        })
//    }
//    
//    
//}
//
