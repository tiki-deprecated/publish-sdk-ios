/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    let origin = "com.mytiki.tiki_sdk_example"
    let publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
    
    @State var tikiSdk: TikiSdk? = nil
    @State var wallets: [String] = []
    @State var bodyData: String = "{\"message\" : \"Hello Tiki!\"}"
    @State var httpMethod: String = "POST"
    @State var url: String = "https://postman-echo.com/post"
    @State var interval: Int = 1
    @State var ownership: TikiSdkOwnership? = nil
    @State var consent: TikiSdkConsent? = nil
    @State var requests: [Request] = []
    @State var toggleState: Bool = false
    @State var timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    @State var showSheet = false
    @State var sheetMsg = ""
    
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
                            Text("Try it Out")
                                .font(.largeTitle).bold()
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading).listRowInsets(EdgeInsets()).padding(.bottom)
                        }.padding(.top)
                        .listRowInsets(EdgeInsets())
                        .background(Color(.systemGroupedBackground))
                        Section(header: Text("Wallet").foregroundColor(.black).bold().font(.system(size: 19)).listRowInsets(EdgeInsets()).padding(.bottom)) {
                            NavigationLink(destination: WalletView(wallets: $wallets, tikiSdk: $tikiSdk, ownership: $ownership, bodyData: $bodyData)) {
                                Text(tikiSdk!.address!.prefix(28) + "...").font(.system(size:16))
                            }
                        }.textCase(nil)
                        if(ownership != nil){
                            Section {
                                VStack(alignment: .leading){
                                    NavigationLink(destination: OwnershipView(ownership: ownership!)) {
                                        Text("Ownership NFT")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(.blue)
                                            .multilineTextAlignment(.leading)
                                            .listRowSeparator(.hidden)
                                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                    Text(ownership!.transactionId.prefix(32) + "...").font(.system(size: 14))
                                    .fontWeight(.medium)}.padding([.top,.bottom],5)
                            }}
                        Section {
                            VStack(alignment: .leading){
                                NavigationLink(destination: ConsentView(consent: consent)) {
                                    Text("Consent NFT")
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundColor(.blue)
                                        .multilineTextAlignment(.leading)
                                        .listRowSeparator(.hidden)
                                }.padding([.top, .bottom],5)
                                .disabled(consent == nil)
                                Text(consent != nil ? consent!.transactionId.prefix(16) + "..." : "No consent").font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .padding(.bottom, 10)
                                Divider()
                                Toggle("Toggle consent", isOn: $toggleState).font(.system(size: 14))
                                    .onChange(of: toggleState) { toggleState in
                                        toggleConsent()
                                    }.padding([.top,.bottom], 5)
                            }
                        }
                        Section(header: Text("Outbound Request(s)").foregroundColor(.black).bold().font(.system(size: 19)).listRowInsets(EdgeInsets()).padding(.bottom)) {
                            VStack(alignment: .leading){
                                NavigationLink(destination: DestinationEditView(url: $url, httpMethod: $httpMethod, interval: $interval)) {
                                    Text("Destination")
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundColor(.blue)
                                        .multilineTextAlignment(.leading)
                                        .listRowSeparator(.hidden)
                                }.padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
                                Text(httpMethod + " " + url).font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .padding(.bottom, 10)
                            }
                        }.textCase(nil)
                        Section {
                            VStack(alignment: .leading){NavigationLink(destination: BodyEditView(bodyData: $bodyData)) {
                                Text("Body (JSON)")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                                    .multilineTextAlignment(.leading)
                                    .listRowSeparator(.hidden)
                            }.padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
                            Text(bodyData).font(.system(size: 14))
                                .fontWeight(.medium).padding(.bottom, 10)}
                        }
                        Section {
                            Text("Requests")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                                .multilineTextAlignment(.leading)
                                .listRowSeparator(.hidden)
                            ForEach(0..<requests.count, id: \.self) { index in
                                let reqLog = requests[requests.count-index-1]
                                HStack{
                                    Text(reqLog.icon).font(.system(size: 14)).fontWeight(.medium)
                                    Text(reqLog.message.replacingOccurrences(of: "[\r\\n]+", with: "", options: .regularExpression, range: Range(uncheckedBounds: (lower: reqLog.message.startIndex, upper: reqLog.message.endIndex)))).font(.system(size: 14)).fontWeight(.medium).lineLimit(1).truncationMode(.tail)
                                    Spacer()
                                    Text(reqLog.timestamp).foregroundColor(.gray).font(.system(size: 12)).fontWeight(.medium)
                                }.listRowSeparator(.hidden)
                                .onTapGesture {
                                    showSheet = true
                                    sheetMsg = requests[requests.count-index-1].message
                                }
                                .sheet(isPresented: $showSheet, content: {
                                    Text(sheetMsg).padding()
                                })
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
                self.tikiSdk = try await TikiSdk(origin: origin, publishingId: publishingId)
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
