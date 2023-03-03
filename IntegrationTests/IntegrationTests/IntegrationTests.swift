/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import XCTest
@testable import TikiSdk
import SwiftUI

class IntegrationTests: XCTestCase {

    let origin = "com.mytiki.iostest"
    let publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88"

    
    func testInitSdk() async throws {
        do{
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId)
            XCTAssert(TikiSdk.address != nil)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testTikiSdkConfig() async throws{
        do{
            try await TikiSdk.config()
                .theme
                    .setPrimaryTextColor(.white)
                    .setPrimaryBackgroundColor(.white)
                    .setSecondaryBackgroundColor(.white)
                    .setAccentColor(.white)
                    .setFontFamily("test")
                    .and()
                .dark
                    .setPrimaryTextColor(.white)
                    .setPrimaryBackgroundColor(.white)
                    .setSecondaryBackgroundColor(.white)
                    .setAccentColor(.white)
                    .setFontFamily("test")
                    .and()
                .offer
                    .setId("randomId")
                    .addUsedBullet(UsedBullet(text: "test 1", isUsed: true))
                    .addUsedBullet(UsedBullet(text: "test 2", isUsed: false))
                    .addUsedBullet(UsedBullet(text: "test 3", isUsed: true))
                    .setPtr("source")
                    .setDescription("testing")
                    .setTerms("path/terms.md")
                    .addUse("tbd uses")
                    .addTag("tbd tags")
                    .setExpiry(expiry: Date().addingTimeInterval(365 * 24 * 60 * 60))
                    .addReqPermission(permission: "camera")
                    .add()
                .offer
                    .setId("randomId2")
                    .addUsedBullet(UsedBullet(text: "test 1", isUsed: true))
                    .addUsedBullet(UsedBullet(text: "test 2", isUsed: true))
                    .addUsedBullet(UsedBullet(text: "test 3", isUsed: true))
                    .setPtr("source")
                    .setDescription("testing2")
                    .setTerms("path/terms.md")
                    .addUse("tbd uses")
                    .addTag("tbd tags")
                    .setExpiry(expiry: Date().addingTimeInterval(365 * 24 * 60 * 60))
                    .addReqPermission(permission: "camera")
                    .add()
                .setOnAccept { offer in }
                .setOnDecline { offer in }
                .setOnSettings { offer in }
                .disableAcceptEnding(false)
                .disableDeclineEnding(true)
                .initTikiSdk(publishingId: publishingId)
            XCTAssert(TikiSdk.address != nil)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    
    func testInitSdkWithAddress() async throws {
        do{
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId)
            let address = TikiSdk.address
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId, address: address)
            let address2 = TikiSdk.address
            XCTAssertEqual(address, address2)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAssignOwnership() async throws {
        do{
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId)
            let ownershipId = try await TikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            XCTAssert(ownershipId.lengthOfBytes(using: .utf8) > 32)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    func testGetOwnership() async throws {
        do{
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId)
            let ownershipId = try await TikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let ownership = try await TikiSdk.getOwnership(source: "testAssign")
            XCTAssert(ownershipId == ownership!.transactionId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    func testModifyConsent() async throws {
        do{
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId)
            let ownershipId = try await TikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let consent = try await TikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all(), about: "about", reward: "some reward", expiry: nil)
            XCTAssert(consent.ownershipId == ownershipId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testConsentExpiration() async throws {
        do{
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId)
            let ownershipId = try await TikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let date = Calendar.current.date(byAdding: .year, value: 1, to: Date())
            let consent = try await TikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all(), about: "about", reward: "some reward", expiry: date)
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
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId)
            let ownershipId = try await TikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let consent = try await TikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all(), about: "about", reward: "some reward", expiry: nil)
            let getConsent = try await TikiSdk.getConsent(source: "testAssign")
            XCTAssert(consent.ownershipId == getConsent?.ownershipId)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    func testApplyConsent() async throws {
        do{
            var ok = false
            try await TikiSdk.config().initTikiSdk(publishingId: publishingId)
            let ownershipId = try await TikiSdk.assignOwnership(source: "testAssign", type: TikiSdkDataTypeEnum.point, contains: ["test data"], about: "test case")
            let _ = try await TikiSdk.modifyConsent(ownershipId: ownershipId, destination: TikiSdkDestination.all(), about: "about", reward: "some reward", expiry: nil)
            try await TikiSdk.applyConsent(source: "testAssign", destination: TikiSdkDestination.all(), request: {
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
