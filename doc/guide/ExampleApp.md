---
title: Example App
excerpt: Getting started with the TIKI SDK iOS sample application
category: 6392d60b0bf6850082188e5c
parentDoc: 63db61b618f66b03e938f191
slug: tiki-sdk-ios-example-app
hidden: false
order: 2
---

1. Clone the TIKI SDK iOS repository.


`git clone https://github.com/tiki/tiki-sdk-ios.git`
  
2. Open the tiki-sdk-ios/ExampleApp/SwiftUI/TikiSdkExample.xcodeproj in XCode  

3. Run the app in the simulator or physical device

_Note: The TIKI SDK iOS repository [main branch](https://github.com/tiki/) keeps the Debug version of the dependency Frameworks. To run the Release version, checkout the latest tag._

## SDK initialization

The first initialization of the SDK is done by the `initTikiSdk` functin. It calls the `TikiSdk`constructor owithout passing a wallet address as a parameter This tells the TIKI SDK to create a new wallet on startup. The corresponding TikiSdk object is saved in the SDK Dictionary, with the address as the key.

#### TikiSdkExample/SwiftUI/TikiSdkExample/TikiSdkExampleApp.swift - 169 to 181
```
func initTikiSdk() {
  Task{
    do{
        self.tikiSdk = try  await TikiSdk(origin: origin, publishingId: publishingId)
        self.wallets = [tikiSdk!.address!]
        ...
      }catch{
		print(error.localizedDescription)
	  }
  }
 }
```
It is possible to create and switch wallets while using the application. This functionality is used to simulate SDK initialization on a device where the user has previously created a wallet or in a multi-tenant application. When a valid address is passed as a parameter a new TIKI SDK iOS instance is created for the wallet.

_Note: The TIKI SDK requires a valid private key for the address, saved in its secure storage. This is managed automatically by the SDK for any wallets created locally._

#### TikiSdkExample/SwiftUI/TikiSdkExample/WalletView.swift - 42 to 80
```
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
```

**Important:** By design, the TIKI SDK does not save the addresses of created wallets. This information must be saved by the application in a local or remote persistence.

## Ownership NFT

When a new wallet is created, the application creates an Ownership NFT for the default data source using the `assignOwnership` call and passing said data source. The source parameter can be any String that uniquely identifies the data. For this example, we use a random UUID defined in the destination object.

#### TikiSdkExample/SwiftUI/TikiSdkExample/TikiSdkExampleApp.swift - 172 to 176

```
    let source = Data(bodyData.utf8).base64EncodedString()
    let _ = try  await tikiSdk!.assignOwnership(source: source, type: TikiSdkDataTypeEnum.stream, contains: ["generic data"], about: "Data stream created with TIKI SDK Sample App")
    self.ownership = try  await tikiSdk!.getOwnership(source: source)!
```
## Consent NFT
No Consent NFT is created until a user action to allow/disallow the usage of its data. The requested URL is used as the `TikiSdkDestination.paths`, and the method is marked as the `TikiSdkDestination.uses` case.

#### TikiSdkExample/SwiftUI/TikiSdkExample/TikiSdkExampleApp.swift  - lines 227 to 241
```
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
```
Additional Consent NFTs are created when the user turns the _"toggle consent"_ switch on or off. When changing other destination data, the Consent NFT is not modified.
## Outbound Requests
The example app executes an HTTP request in the time interval defined in the destination screen. Before each request, the app calls the `applyConsent` method from TIKI SDK. If Consent has been given, the request is executed. If not, the request is denied and a blocked message is showed in the log.
#### TikiSdkExample/SwiftUI/TikiSdkExample/TikiSdkExampleApp.swift  - lines 183 to 225
```
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
```
## Testing

The purpose of this sample app is for developers to try out the core features and become familiar with implementing the TIKI SDK in iOS. Clone the repository and modify however you want. If you find any bugs, please create issues or send in PRs!

For any questions you can contact the team on [Discord](https://discord.gg/tiki). Have fun!