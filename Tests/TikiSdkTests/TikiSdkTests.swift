import XCTest
@testable import TikiSdk

final class TikiSdkTests: XCTestCase {
    
    let apiKey = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90"
    var tikiSdk : TikiSdk?

    func testBuild(){
        var ok = false
        var result = false
        tikiSdk = TikiSdk(
            origin: "com.mytiki.iosTests",
            apiKey: apiKey,
            onBuild: { success, response in
                result = true
                ok = success
            })
        while(!result){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {}
        }
        XCTAssertTrue(ok)
    }
        
//    func testAssign(){
//        print("assign")
//        tikiSdk!.assignOwnership(source: "assign test", type: "data_pool", contains: ["test data"], completion: { success, result in
//            print(success)
//            print(result)
//        })
//    }
//
//    func testGiveConsent(){
//        print("give")
//        tikiSdk!.modifyConsent(source: "assign test", destination:  TikiSdkDestination.all(), completion: { success, result in
//            print(success)
//            print(result)
//        })
//    }
//
//    func testGetConsent(){
//        print("get")
//        tikiSdk!.getConsent(source: "assign test", completion: { success, result in
//            print(success)
//            print(result)
//        })
//    }
//        
//    func testApplyConsent(){
//        print("applyConsent")
//        tikiSdk!.applyConsent(source: "assign test", destination: TikiSdkDestination.all(), request: { response in print(response)}, onBlock: { response in
//            print(response)
//        })
//    }
}
