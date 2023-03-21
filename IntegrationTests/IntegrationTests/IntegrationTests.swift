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
    let id = UUID().uuidString

    
    func testInitSdk() async throws {
        do{
            try await TikiSdk.config().initialize(publishingId: publishingId, id:id)
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
                    .id("randomId")
                    .bullet(text: "test 1", isUsed: true)
                    .bullet(text: "test 2", isUsed: false)
                    .bullet(text: "test 3", isUsed: true)
                    .ptr("source")
                    .description("testing")
                    .terms("myTerms")
                    .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                    .tag(TitleTag(TitleTagEnum.advertisingData))
                    .duration(365 * 24 * 60 * 60)
                    .permission(PermissionType.camera)
                    .add()
                .offer
                    .id("randomId2")
                    .bullet(text: "test 1", isUsed: true)
                    .bullet(text: "test 2", isUsed: true)
                    .bullet(text: "test 3", isUsed: true)
                    .ptr("source2")
                    .description("testing")
                    .terms("myTerms")
                    .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                    .tag(TitleTag(TitleTagEnum.advertisingData))
                    .duration(365 * 24 * 60 * 60)
                    .permission(PermissionType.camera)
                    .add()
                .onAccept { _, __ in }
                .onDecline { _, __ in }
                .onSettings { }
                .disableAcceptEnding(false)
                .disableDeclineEnding(true)
                .initialize(publishingId: publishingId, id:id)
            XCTAssert(TikiSdk.address != nil)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

    
    func testInitSdkWithAddress() async throws {
        do{
            try await TikiSdk.config().initialize(publishingId: publishingId, id:id)
            let address = TikiSdk.address
            try await TikiSdk.config().initialize(publishingId: publishingId, id:id)
            let address2 = TikiSdk.address
            XCTAssertEqual(address, address2)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testLicense() async throws{
        do{
            try await TikiSdk.config().initialize(publishingId: publishingId, id:id)
            let offer = Offer()
                .id("randomId")
                .bullet(text: "test 1", isUsed: true)
                .bullet(text: "test 2", isUsed: false)
                .bullet(text: "test 3", isUsed: true)
                .ptr("source")
                .description("testing")
                .terms("path/terms.md")
                .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                .tag(TitleTag(TitleTagEnum.advertisingData))
                .permission(PermissionType.camera)
            let license = try await TikiSdk.license(offer: offer)
            XCTAssertEqual(license.description, "testing")
            XCTAssertEqual(license.uses[0].usecases[0].value, LicenseUsecase(LicenseUsecaseEnum.support).value)
            XCTAssertEqual(license.title.tags[0].value, TitleTagEnum.advertisingData.rawValue)
        }catch{
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func testGuard() async throws{
        do{
            try await TikiSdk.config().initialize(publishingId: publishingId, id:id)
            let offer = Offer()
                .id("randomId")
                .bullet(text: "test 1", isUsed: true)
                .bullet(text: "test 2", isUsed: false)
                .bullet(text: "test 3", isUsed: true)
                .ptr("source")
                .description("testing")
                .terms("path/terms.md")
                .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                .tag(TitleTag(TitleTagEnum.advertisingData))
                .permission(PermissionType.camera)
            let license = try await TikiSdk.license(offer: offer)
            let guardResult = try await TikiSdk.guard(ptr: "source", usecases:[LicenseUsecase(LicenseUsecaseEnum.support)], destinations: [])
            XCTAssert(guardResult)
        }catch{
            print(error)
            XCTFail(error.localizedDescription)
        }
    }

}
