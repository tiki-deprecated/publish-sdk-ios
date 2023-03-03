/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import XCTest
@testable import TikiSdk

class IntegrationTests: XCTestCase {

    let origin = "com.mytiki.iostest"
    let publishingId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90"

    
    func testInitSdk() async throws {
        do{
            let tikiSdk : TikiSdk = TikiSdk.config()
            try await tikiSdk.initTikiSdk(publishingId: publishingId)
            XCTAssert(tikiSdk.address != nil)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testInitSdkWithAddress() async throws {
        do{
            let tikiSdk : TikiSdk = TikiSdk.config()
            try await tikiSdk.initTikiSdk(publishingId: publishingId)
            let address = TikiSdk.instance.address
            try await tikiSdk.initTikiSdk(publishingId: publishingId, address: address)
            let address2 = TikiSdk.instance.address
            XCTAssertEqual(address, address2)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAssignOwnership() async throws {
        do{
            let tikiSdk : TikiSdk = TikiSdk.config()
            try await tikiSdk.initTikiSdk(publishingId: publishingId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            XCTAssert(ownershipId.lengthOfBytes(using: .utf8) > 32)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    func testGetOwnership() async throws {
        do{
            let tikiSdk : TikiSdk = TikiSdk.config()
            try await tikiSdk.initTikiSdk(publishingId: publishingId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let ownership = try await tikiSdk.getOwnership(source: "testAssign")
            XCTAssert(ownershipId == ownership!.transactionId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    func testModifyConsent() async throws {
        do{
            let tikiSdk : TikiSdk = TikiSdk.config()
            try await tikiSdk.initTikiSdk(publishingId: publishingId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let consent = try await tikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all(), about: "about", reward: "some reward", expiry: nil)
            XCTAssert(consent.ownershipId == ownershipId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testConsentExpiration() async throws {
        do{
            let tikiSdk : TikiSdk = TikiSdk.config()
            try await tikiSdk.initTikiSdk(publishingId: publishingId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let date = Calendar.current.date(byAdding: .year, value: 1, to: Date())
            let consent = try await tikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all(), about: "about", reward: "some reward", expiry: date)
            XCTAssert(consent.ownershipId == ownershipId)
            let d1 = floor(consent.expiry!.timeIntervalSince1970)
            let d2 = floor(date!.timeIntervalSince1970)
            XCTAssert(d1 == d2 )
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    func testGetConsent() async throws {
        do{
            let tikiSdk : TikiSdk = TikiSdk.config()
            try await tikiSdk.initTikiSdk(publishingId: publishingId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let consent = try await tikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all(), about: "about", reward: "some reward", expiry: nil)
            let getConsent = try await tikiSdk.getConsent(source: "testAssign")
            XCTAssert(consent.ownershipId == getConsent?.ownershipId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    func testApplyConsent() async throws {
        do{
            var ok = false
            let tikiSdk : TikiSdk = TikiSdk.config()
            try await tikiSdk.initTikiSdk(publishingId: publishingId)
            let ownershipId = try await tikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let _ = try await tikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all(), about: "about", reward: "some reward", expiry: nil)
            try await tikiSdk.applyConsent(source: "testAssign", destination: TikiSdkDestination.all(), request: {
                ok = true
            }, onBlocked: { msg in
                XCTFail(msg)
            })
            XCTAssert(ok)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

}
