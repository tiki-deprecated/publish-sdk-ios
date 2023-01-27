/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    @StateObject var appModel: TikiSdkExampleAppModel = TikiSdkExampleAppModel()
    @State var log: [StreamLog] = []
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some Scene {
        WindowGroup {
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
                        NavigationLink(destination: WalletView()) {
                            Text(appModel.tikiSdk == nil ? "Create a Wallet" : appModel.tikiSdk!.address!)
                        }
                    }
                    if(appModel.tikiSdk != nil){
                        if(appModel.ownership != nil){
                            let ownership = appModel.ownership
                            Section {
                                VStack(alignment: .leading){
                                NavigationLink(destination: OwnershipView()) {
                                    Text("Ownership NFT").foregroundColor(.blue)
                                        .multilineTextAlignment(.leading)
                                        .listRowSeparator(.hidden)
                                }
                                Text(ownership!.transactionId.prefix(16) + "...")}
                            }
                            if(appModel.consent != nil){
                                let consent = appModel.consent
                                VStack(alignment: .leading){
                                    Section {
                                    NavigationLink(destination: ConsentView()) {
                                        Text("Consent NFT").foregroundColor(.blue).multilineTextAlignment(.leading)
                                            .listRowSeparator(.hidden)
                                    }
                                    Text(consent!.transactionId.prefix(16) + "...")
                                    Toggle("ToggleConsent", isOn: $appModel.isConsentGiven)
                                        .onChange(of: appModel.isConsentGiven) { isConsentGiven in
                                            toggleConsent()
                                        }
                                }}
                            }
                        }
                    }
                    Section(header: Text("Outbound Request(s)")) {
                        VStack(
                            alignment: .leading){NavigationLink(destination: StreamEditView()) {
                            Text("Destination").foregroundColor(.blue).multilineTextAlignment(.leading)
                                .listRowSeparator(.hidden)
                        }
                        Text(appModel.stream.httpMethod + " " + appModel.stream.url)}
                        
                    }
                    Section {
                        VStack(alignment: .leading){NavigationLink(destination: StreamBodyView()) {
                                Text("Body (JSON)")
                        }
                        Text(appModel.stream.body)}
                    }
                    Section {
                        Text("Requests")
                        ForEach(0..<$log.count, id: \.self) { index in
                            let reqLog = log[log.count-index-1]
                            HStack{
                                Text(reqLog.icon)
                                Text(reqLog.message)
                                Spacer()
                                Text(reqLog.timestamp).font(.system(size: 10))
                            }
                        }
                    }
                }.onAppear{
                    let seconds = appModel.stream.interval
                    timer = Timer.publish(every: Double(seconds), on: .main, in: .common).autoconnect()
                }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .onReceive(timer) { _ in
                    sendDataToServer()
                }.environmentObject(appModel)
        }
    }
    
    func sendDataToServer(){
        if(appModel.tikiSdk == nil){
            log.append(StreamLog(icon: "🔴", message: "ERROR: Create a Wallet"))
        }else{
            Task{
                let url = URL(string: appModel.stream.url)!
                let path: String = url.host!
                let use: String = appModel.stream.httpMethod
                let destination = TikiSdkDestination(paths: [path], uses: [use])
                let body: String = appModel.stream.body
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = Data(body.utf8)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                try await appModel.tikiSdk!.applyConsent(source: appModel.stream.source, destination: destination, request: {
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard
                            let data = data,
                            let response = response as? HTTPURLResponse,
                            error == nil
                        else {
                            log.append(StreamLog(icon: "🔴", message: "ERROR: \(error?.localizedDescription ?? URLError(.badServerResponse).localizedDescription)"))
                            return
                        }
                        
                        guard (200 ... 299) ~= response.statusCode else {
                            log.append(StreamLog(icon: "🔴", message:"\(response.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))"))
                            return
                        }
                        do{
                            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                            guard let jsonDictionary : Dictionary<String, AnyObject> = jsonData["json"] as? Dictionary else{
                                log.append(StreamLog(icon: "🔴", message: "Error: Malformed JSON repsonse"))
                                return
                            }
                            log.append(StreamLog(icon:"🟢", message:"\(response.statusCode): \(jsonDictionary)"))
                            DispatchQueue.main.async {
                                appModel.isConsentGiven = true
                            }
                        }catch{
                            log.append(StreamLog(icon: "🔴", message: "Error: \(error.localizedDescription)"))
                            return
                        }
                    }
                    task.resume()
                }, onBlocked: { reason in
                    log.append(StreamLog(icon: "🔴", message: "Blocked: consent required"))
                    DispatchQueue.main.async {
                        appModel.isConsentGiven = false
                    }
                    return
                })
            }}
    }
    
    func toggleConsent(){
        Task{
            do{
                let path: String = URL(string:appModel.stream.url)!.host!
                let use: String = appModel.stream.httpMethod
                let destination = appModel.isConsentGiven ?
                    TikiSdkDestination.none() :
                    TikiSdkDestination(paths: [path], uses: [use])
                let consent: TikiSdkConsent = try await appModel.tikiSdk!.modifyConsent(ownershipId: appModel.ownership!.transactionId, destination: destination, about: "Consent given to echo data in remote server", reward: "Test the SDK", expiry: Calendar.current.date(byAdding: DateComponents(year: 10), to: Date())!)
                appModel.consentDictionary[appModel.ownership!.transactionId] = consent
                appModel.isConsentGiven.toggle()
            }catch{
                print(error)
            }
        }
    }
}
