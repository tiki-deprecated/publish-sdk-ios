//
//  StreamView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 10/01/23.
//

import SwiftUI
import TikiSdk



struct StreamDetailView: View {
    
    var tikiSdk: TikiSdk
    @State var stream: Stream
    @State var log: [String] = []
    @State var isConsentGiven = false
    @State var ownership: TikiSdkOwnership?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            List {
                ForEach(0..<log.count, id: \.self) { index in
                    Text(log[log.count-index-1])
                }
            }
            Button(isConsentGiven ? "Revoke Consent" : "GiveConsent") {
                toggleConsent()
            }
            Spacer().frame(height: 30)
            if(ownership != nil){
                NavigationLink(destination: OwnershipDetailView(tikiSdk: tikiSdk, ownership: ownership)) {
                    Text("Ownership NFT")
                }
            }
        }.onReceive(timer) { _ in
            sendDataToServer()
        }.onAppear(perform: {
            Task{
                do{
                    sendDataToServer()
                    ownership = try await tikiSdk.getOwnership(source: stream.source)!
                }catch{
                    print(error)
                }
            }
        })
    }
    
    func sendDataToServer(){
        Task{
            let url = URL(string: "https://postman-echo.com/post")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = Data(stream.data.utf8)
            try await tikiSdk.applyConsent(source: stream.source, destination: TikiSdkDestination(paths: ["postman-echo.com/post"], uses: ["streamData"]), request: {
                isConsentGiven = true
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        error == nil
                    else {
                        log.append("🔴 ERROR: \(error?.localizedDescription ?? URLError(.badServerResponse).localizedDescription)")
                        return
                    }
                    
                    guard (200 ... 299) ~= response.statusCode else {
                        log.append("🔴 \(response.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
                        return
                    }
                    do{
                        let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let logString : String = jsonDictionary["data"] as! String
                        log.append("🟢 \(response.statusCode): \(logString)")
                    }catch{
                        log.append("🔴 DECODE ERROR: \(error.localizedDescription)")
                        return
                    }
                }
                task.resume()
            }, onBlocked: { reason in
                isConsentGiven = false
                log.append("🔴 Blocked: \(reason)")
                return
            })
        }
    }
    
    func toggleConsent(){
        Task{
            do{
                let ownership: TikiSdkOwnership? = try await tikiSdk.getOwnership(source: stream.source)
                if(ownership != nil){
                    let destination = isConsentGiven ? TikiSdkDestination.none() : TikiSdkDestination(paths: ["postman-echo.com/post"], uses: ["streamData"])
                    let _: TikiSdkConsent = try await tikiSdk.modifyConsent(ownershipId: ownership!.transactionId, destination: destination, about: "Consent given to echo data in remote server")
                }
            }catch{
                print(error)
            }
        }
    }
}

