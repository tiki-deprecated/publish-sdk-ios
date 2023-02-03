///*
// * Copyright (c) TIKI Inc.
// * MIT license. See LICENSE file in root directory.
// */
//
//import SwiftUI
//import TikiSdk
//
//struct ds {
//    
//    @StateObject var appModel: TikiSdkExampleAppModel = TikiSdkExampleAppModel()
//    @State var log: [StreamLog] = []
//    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    
//    var body: some Scene {
//        WindowGroup {
//            NavigationView{
//                List{
//                    Section{
//                        Text("Try it out").fontWeight(.heavy)
//                            .font(.largeTitle).padding()
//                            .multilineTextAlignment(.leading).frame(maxWidth: .infinity)
//                    }
//                    .listRowInsets(EdgeInsets())
//                    .background(Color(.systemGroupedBackground))
//                    Section(header: Text("Wallet")) {
//                        NavigationLink(destination: WalletView()) {
//                            Text(appModel.tikiSdk == nil ? "Create a Wallet" : appModel.tikiSdk!.address!)
//                        }
//                    }
//                    if(appModel.tikiSdk != nil){
//                        if(appModel.ownership != nil){
//                            let ownership = appModel.ownership
//                            Section {
//                                VStack(alignment: .leading){
//                                NavigationLink(destination: OwnershipView()) {
//                                    Text("Ownership NFT").foregroundColor(.blue)
//                                        .multilineTextAlignment(.leading)
//                                        .listRowSeparator(.hidden)
//                                }
//                                Text(ownership!.transactionId.prefix(16) + "...")}
//                            }
//                            if(appModel.consent != nil){
//                                let consent = appModel.consent
//                                VStack(alignment: .leading){
//                                    Section {
//                                    NavigationLink(destination: ConsentView()) {
//                                        Text("Consent NFT").foregroundColor(.blue).multilineTextAlignment(.leading)
//                                            .listRowSeparator(.hidden)
//                                    }
//                                    Text(consent!.transactionId.prefix(16) + "...")
//                                    Toggle("ToggleConsent", isOn: $appModel.isConsentGiven)
//                                        .onChange(of: appModel.isConsentGiven) { isConsentGiven in
//                                            toggleConsent()
//                                        }
//                                }}
//                            }
//                        }
//                    }
//                    Section(header: Text("Outbound Request(s)")) {
//                        VStack(
//                            alignment: .leading){NavigationLink(destination: StreamEditView()) {
//                            Text("Destination").foregroundColor(.blue).multilineTextAlignment(.leading)
//                                .listRowSeparator(.hidden)
//                        }
//                        Text(appModel.stream.httpMethod + " " + appModel.stream.url)}
//                        
//                    }
//                    Section {
//                        VStack(alignment: .leading){NavigationLink(destination: StreamBodyView()) {
//                                Text("Body (JSON)")
//                        }
//                        Text(appModel.stream.body)}
//                    }
//                    Section {
//                        Text("Requests")
//                        ForEach(0..<$log.count, id: \.self) { index in
//                            let reqLog = log[log.count-index-1]
//                            HStack{
//                                Text(reqLog.icon)
//                                Text(reqLog.message)
//                                Spacer()
//                                Text(reqLog.timestamp).font(.system(size: 10))
//                            }
//                        }
//                    }
//                }.onAppear{
//                    let seconds = appModel.stream.interval
//                    timer = Timer.publish(every: Double(seconds), on: .main, in: .common).autoconnect()
//                }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
//            }.navigationBarTitle("")
//                .navigationBarHidden(true)
//                .onReceive(timer) { _ in
//                    sendDataToServer()
//                }.environmentObject(appModel)
//        }
//    }
//    
//
//}
