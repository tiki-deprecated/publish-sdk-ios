---
title: Example App
excerpt: Getting started with the TIKI SDK iOS sample application
category: 6392d60b0bf6850082188e5c
parentDoc: 63db61b618f66b03e938f191
slug: tiki-sdk-ios-example-app
hidden: false
order: 2
---

1.	Clone the TIKI SDK iOS repository.

`git clone https://github.com/tiki/tiki-sdk-ios.git`

2.	Open the tiki-sdk-ios/ExampleApp/SwiftUI/TikiSdkExample.xcodeproj in XCode

3.	Run the app in the simulator or physical device

_Note: The TIKI SDK iOS repository main branch keeps the Debug version of the dependency Frameworks. To run the Release version, checkout the latest tag._

## SDK initialization

The first initialization of the SDK is done without passing a wallet address as a parameter This tells the TIKI SDK to create a new wallet on startup. The corresponding TikiSdk object is saved in the SDK Dictionary, with the address as the key.

#### TikiSdkExample/SwiftUI/TikiSdkExample/Wallet/WalletView.swift - lines 41 to 46

```
let origin = "com.mytiki.tiki_sdk_example"
let apiId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90"
let tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
appModel.walletList.append(tikiSdk.address!)
appModel.wallets[tikiSdk.address!] = tikiSdk
appModel.selectedWalletAddress = tikiSdk.address!
```

It is possible to switch wallets while using the application. This functionality is used to simulate SDK initialization on a device where the user has previously created a wallet or in a multi-tenant application. When a valid address is passed as a parameter a new TIKI SDK iOS instance is created for the wallet.

_Note: The TIKI SDK requires a valid private key for the address, saved in its secure storage. This is managed automatically by the SDK for any wallets created locally._

#### TikiSdkExample/SwiftUI/TikiSdkExample/Wallet/WalletView.swift - lines 67 to 70

```
func switchTo(addr: String){
    appModel.selectedWalletAddress = addr
    self.presentationMode.wrappedValue.dismiss()
}
```

**Important:** By design, the TIKI SDK does not save the addresses of created wallets. This information must be saved by the application in a local or remote persistence.

## Ownership NFT

When a new wallet is created, the application creates an Ownership NFT for the default data source using the `assignOwnership` call and passing said data source. The source parameter can be any String that uniquely identifies the data. For this example, we use a random UUID defined in the destination object.

#### TikiSdkExample/SwiftUI/TikiSdkExample/Wallet/WalletView.swift - lines 48 to 56

```
let _ = try await appModel.tikiSdk!.assignOwnership(
    source: appModel.stream.source, 
    type: TikiSdkDataTypeEnum.stream, 
    contains: ["generic data"], 
    about: "Data stream created with TIKI SDK Sample App")
let ownership = try await appModel.tikiSdk?.getOwnership(source: appModel.stream.source)
appModel.ownershipDictionary[tikiSdk.address!] = ownership!
```

## Consent NFT

In the sample application, for convenience, we auto-create a Consent NFT on wallet initialization. The requested URL is used as the `TikiSdkDestination` path, and the method is marked as the use case.

#### TikiSdkExample/SwiftUI/TikiSdkExample/Wallet/WalletView.swift - lines 52 to 58

```
let path: String = URL(string:appModel.stream.url)!.host!
let use: String = appModel.stream.httpMethod
let destination = TikiSdkDestination(paths: [path], uses: [use])
let consent: TikiSdkConsent = try await appModel.tikiSdk!.modifyConsent(
    ownershipId: appModel.ownership!.transactionId, 
    destination: destination, 
    about: "Consent given to echo data in remote server", 
    reward: "Test the SDK", 
    expiry: Calendar.current.date(byAdding: DateComponents(year: 10), to: Date())!)
appModel.consentDictionary[ownership!.transactionId] = consent
appModel.isConsentGiven = true
isLoading = false
```

Additional Consent NFTs are created when the user turns the _"toggle consent"_ switch on or off. When changing other destination data, the Consent NFT is not modified.

## Outbound Requests

The example app executes an HTTP request in the time interval defined in the destination screen. Before each request, the app calls the `applyConsent` method from TIKI SDK. If Consent has been given, the request is executed. If not, the request is denied and a blocked message is showed in the log.

```
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
```

## Testing

The purpose of this sample app is for developers to try out the core features and become familiar with implementing the TIKI SDK in iOS. Clone the repository and modify however you want. If you find any bugs, please create issues or send in PRs!

For any questions you can contact the team on [Discord](https://discord.gg/tiki). Have fun!
