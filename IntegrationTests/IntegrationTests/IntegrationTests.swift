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
            try await TikiSdk.config().initialize(publishingId: publishingId)
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
                    .addUse(LicenseUse(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)]))
                    .addTag(TitleTag(TitleTagEnum.advertisingData))
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
                    .addUse(LicenseUse(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)]))
                    .addTag(TitleTag(TitleTagEnum.advertisingData))
                    .setExpiry(expiry: Date().addingTimeInterval(365 * 24 * 60 * 60))
                    .addReqPermission(permission: "camera")
                    .add()
                .setOnAccept { offer in }
                .setOnDecline { offer in }
                .setOnSettings { offer in }
                .disableAcceptEnding(false)
                .disableDeclineEnding(true)
                .initialize(publishingId: publishingId)
            XCTAssert(TikiSdk.address != nil)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    
    func testInitSdkWithAddress() async throws {
        do{
            try await TikiSdk.config().initialize(publishingId: publishingId)
            let address = TikiSdk.address
            try await TikiSdk.config().initialize(publishingId: publishingId, address: address)
            let address2 = TikiSdk.address
            XCTAssertEqual(address, address2)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

}
