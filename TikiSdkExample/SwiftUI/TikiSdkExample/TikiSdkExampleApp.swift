/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    let origin = "com.mytiki.tiki_sdk_example"
    let apiId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90"
    
    @State var tikiSdk: TikiSdk? = nil
    @State var wallets: [String] = []
    @State var bodyData: String = "{\"message\" : \"Hello Tiki!\"}"
    @State var httpMethod: String = "POST"
    @State var url: String = "https://postman-echo.com/post"
    @State var interval: Int = 15
    @State var ownership: TikiSdkOwnership? = nil
    @State var consent: TikiSdkConsent? = nil
    @State var requests: [Request] = []
    @State var toggleState: Bool = false
    @State var timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    
    var body: some Scene {
        WindowGroup {
            if(tikiSdk == nil){
                ProgressView().onAppear{
                    initTikiSdk()
                }
            }else{
                NavigationView{
                    List{
                        Section{
                            Text("Try it out").fontWeight(.heavy)
                                .font(.largeTitle).padding()
                                .multilineTextAlignment(.leading).frame(maxWidth: .infinity)
                        }
                        .listRowInsets(EdgeInsets())
                        .background(Color(.systemGroupedBackground))
                        Section(header: Text("Wallet")) {
                            NavigationLink(destination: WalletView(wallets: $wallets, tikiSdk: $tikiSdk, ownership: $ownership, bodyData: $bodyData)) {
                                Text(tikiSdk!.address!)
                            }
                        }
                        if(ownership != nil){
                            Section {
                                VStack(alignment: .leading){
                                    NavigationLink(destination: OwnershipView(ownership: ownership!)) {
                                        Text("Ownership NFT").foregroundColor(.blue)
                                            .multilineTextAlignment(.leading)
                                            .listRowSeparator(.hidden)
                                    }
                                    Text(ownership!.transactionId.prefix(16) + "...")}
                            }}
                        Section {
                            VStack(alignment: .leading){
                                if(consent != nil){
                                    NavigationLink(destination: ConsentView(consent: consent!)) {
                                        Text("Consent NFT").foregroundColor(.blue).multilineTextAlignment(.leading)
                                            .listRowSeparator(.hidden)
                                    }
                                }
                                Text(consent != nil ? consent!.transactionId.prefix(16) + "..." : "No consent")
                                Toggle("Toggle consent", isOn: $toggleState)
                                    .onChange(of: toggleState) { toggleState in
                                        toggleConsent()
                                    }
                                
                            }
                        }
                        Section(header: Text("Outbound Request(s)")) {
                            VStack(
                                alignment: .leading){NavigationLink(destination: DestinationEditView(url: $url, httpMethod: $httpMethod, interval: $interval)) {
                                    Text("Destination").foregroundColor(.blue).multilineTextAlignment(.leading)
                                        .listRowSeparator(.hidden)
                                }
                                    Text(httpMethod + " " + url)}
                            
                        }
                        Section {
                            VStack(alignment: .leading){NavigationLink(destination: BodyEditView(bodyData: $bodyData)) {
                                Text("Body (JSON)")
                            }
                                Text(bodyData)}
                        }
                        Section {
                            Text("Requests")
                            ForEach(0..<requests.count, id: \.self) { index in
                                let reqLog = requests[requests.count-index-1]
                                HStack{
                                    Text(reqLog.icon)
                                    Text(reqLog.message.prefix(32) + "...")
                                    Spacer()
                                    Text(reqLog.timestamp).font(.system(size: 10))
                                }
                            }
                        }
                    }.onAppear{
                        let seconds = interval
                        timer = Timer.publish(every: Double(seconds), on: .main, in: .common).autoconnect()
                        updateOwnership()
                    }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
                }.navigationBarTitle("")
                    .navigationBarHidden(true)
                    .onReceive(timer) { _ in
                        sendDataToServer()
                    }
            }
        }
    }
    
    func updateOwnership(){
        Task{
            do{
                let source = Data(bodyData.utf8).base64EncodedString()
                if(self.ownership?.source != Data(bodyData.utf8).base64EncodedString()){
                    var _ownership = try await tikiSdk!.getOwnership(source: source)
                    if(_ownership == nil){
                        let _ = try await tikiSdk!.assignOwnership(source: source, type: TikiSdkDataTypeEnum.stream, contains: ["generic data"], about: "Data stream created with TIKI SDK Sample App")
                        _ownership = try await tikiSdk!.getOwnership(source: source)!
                    }
                    self.ownership = _ownership
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func initTikiSdk() {
        Task{
            do{
                self.tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
                self.wallets = [tikiSdk!.address!]
                let source = Data(bodyData.utf8).base64EncodedString()
                let _ = try await tikiSdk!.assignOwnership(source: source, type: TikiSdkDataTypeEnum.stream, contains: ["generic data"], about: "Data stream created with TIKI SDK Sample App")
                self.ownership = try await tikiSdk!.getOwnership(source: source)!
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func sendDataToServer(){
        if(tikiSdk == nil){
            requests.append(Request(icon: "🔴", message: "ERROR: Create a Wallet"))
        }else{
            Task{
                let reqUrl = URL(string: url)!
                let path: String = reqUrl.host!
                let destination = TikiSdkDestination(paths: [path], uses: [httpMethod])
                var request = URLRequest(url: reqUrl)
                let source = Data(bodyData.utf8).base64EncodedString()
                request.httpMethod = httpMethod
                request.httpBody = Data(bodyData.utf8)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                try await tikiSdk!.applyConsent(source: source, destination: destination, request: {
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard
                            let data = data,
                            let response = response as? HTTPURLResponse,
                            error == nil
                        else {
                            requests.append(Request(icon: "🔴", message: "ERROR: \(error?.localizedDescription ?? URLError(.badServerResponse).localizedDescription)"))
                            return
                        }
                        
                        guard (200 ... 299) ~= response.statusCode else {
                            requests.append(Request(icon: "🔴", message:"\(response.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))"))
                            return
                        }
                        requests.append(Request(icon:"🟢", message:"\(response.statusCode): \(String(decoding: data, as: UTF8.self))"))
                        DispatchQueue.main.async {
                            toggleState = true
                        }
                    }
                    task.resume()
                }, onBlocked: { reason in
                    requests.append(Request(icon: "🔴", message: "Blocked: consent required"))
                    DispatchQueue.main.async {
                        toggleState = false
                    }
                    return
                })
            }}
    }
    
    func toggleConsent(){
        Task{
            do{
                let path: String = URL(string:url)!.host!
                let use: String = httpMethod
                let destination = toggleState ?
                TikiSdkDestination.none() :
                TikiSdkDestination(paths: [path], uses: [use])
                consent = try await tikiSdk!.modifyConsent(ownershipId: ownership!.transactionId, destination: destination, about: "Consent given to echo data in remote server", reward: "Test the SDK", expiry: Calendar.current.date(byAdding: DateComponents(year: 10), to: Date())!)
                toggleState.toggle()
            }catch{
                print(error)
            }
        }
    }
}
