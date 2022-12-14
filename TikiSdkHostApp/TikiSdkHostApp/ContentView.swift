import SwiftUI
import TikiSdk

var tikiSdk: TikiSdk?

struct ContentView: View {
    var body: some View {
        Button("build", action: {
            Task {
                do{
                    try await build()
                }catch{
                    print(error)
                }
            }
        })
        Button("Assign Ownership", action: {
            assign()
        })
        Button("Give Consent", action: {
            giveConsent()
        })
        Button("Get Consent", action: {
            getConsent()
        })
        Button("Apply consent", action: {
            applyConsent()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func build() async throws{
    tikiSdk = try await TikiSdk(origin: "com.mytiki.ios", apiId: "2b8de004-cbe0-4bd5-bda6-b266d54f5c90")
    print(tikiSdk!.address)
}

func assign(){
    print("assign")
    //tikiSdk!.assignOwnership(source: "assign test", type: "data_pool", contains: ["test data"], =
}

func giveConsent(){
    print("give")
//    tikiSdk!.modifyConsent(source: "assign test", destination:  TikiSdkDestination.all(), completion: { success, result in
//        print(success)
//        print(result)
//    })
}

func getConsent(){
    print("get")
//    tikiSdk!.getConsent(source: "assign test", completion: { success, result in
//        print(success)
//        print(result)
//    })
}

func applyConsent(){
    print("applyConsent")
//    tikiSdk!.applyConsent(source: "assign test", destination: TikiSdkDestination.all(), request: { response in print(response)}, onBlock: { response in
//        print(response)
//    })
}
