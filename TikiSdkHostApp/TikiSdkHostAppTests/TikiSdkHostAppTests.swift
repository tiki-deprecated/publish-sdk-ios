import XCTest
@testable import TikiSdkHostApp
@testable import TikiSdk

class TikiSdkHostAppTests: XCTestCase {

    let origin = "com.mytiki.iostest"
    let apiId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90"

    
    func testConsentFromToJson(){
        
    }
    
    func testOwnershipFromToJson(){
        
    }
    
    func testTikiSdkDataTypeEnumFromToJson(){
        
    }
    
    func testTikiSdkDestinationFromToJson(){
        
    }
    
    func testInitSdk() async throws {
        do{
            let tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
            XCTAssert(tikiSdk.address != nil)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAssignOwnership() async throws {
        do{
            let tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            XCTAssert(ownershipId.lengthOfBytes(using: .utf8) > 32)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetOwnership() async throws {
        do{
            let tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let gotOwnershipId = try await tikiSdk.getOwnership(source: "testAssign")
            XCTAssertEqual(ownershipId,gotOwnershipId.transactionId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGiveConsent() async throws {
        do{
            let tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let consent = try await tikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all())
            XCTAssertEqual(consent?.ownershipId,ownershipId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGetConsent() async throws {
        do{
            let tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let consent = try await tikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all())
            let gotConsent = try await tikiSdk.getConsent(source: "testAssign")
            XCTAssertEqual(consent?.transactionId,gotConsent?.transactionId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testApplyConsent() async throws {
        do{
            var ok = false;
            let tikiSdk = try await TikiSdk(origin: origin, apiId: apiId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let consent = try await tikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all())
            await tikiSdk.applyConsent(source: "testAssign", destination: TikiSdkDestination.all(), request: { ok = true })
            XCTAssertTrue(ok)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
}
