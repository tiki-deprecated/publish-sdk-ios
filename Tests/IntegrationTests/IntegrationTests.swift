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
            try TikiSdk.config().initialize(publishingId: publishingId, id:id, onComplete: {
                XCTAssert(TikiSdk.address != nil)
            })
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testTikiSdkConfig() async throws{
        do{
            try TikiSdk.config()
                .theme
                .primaryTextColor(.white)
                .primaryBackgroundColor(.white)
                .secondaryBackgroundColor(.white)
                .accentColor(.white)
                .fontFamily("test")
                .and()
                .dark
                .primaryTextColor(.white)
                .primaryBackgroundColor(.white)
                .secondaryBackgroundColor(.white)
                .accentColor(.white)
                .fontFamily("test")
                .and()
                .offer
                .id("randomId")
                .bullet(text: "test 1", isUsed: true)
                .bullet(text: "test 2", isUsed: false)
                .bullet(text: "test 3", isUsed: true)
                .ptr("source")
                .description("testing")
                .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                .tag(TitleTag(TitleTagEnum.advertisingData))
                .duration(365 * 24 * 60 * 60)
                .permission(Permission.camera)
                .add()
                .offer
                .id("randomId2")
                .bullet(text: "test 1", isUsed: true)
                .bullet(text: "test 2", isUsed: true)
                .bullet(text: "test 3", isUsed: true)
                .ptr("source2")
                .description("testing")
                .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                .tag(TitleTag(TitleTagEnum.advertisingData))
                .duration(365 * 24 * 60 * 60)
                .permission(Permission.camera)
                .add()
                .onAccept { _, __ in }
                .onDecline { _, __ in }
                .onSettings { }
                .disableAcceptEnding(false)
                .disableDeclineEnding(true)
                .initialize(publishingId: publishingId, id:id, onComplete: {
                    XCTAssert(TikiSdk.address != nil)
                })
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testLicense() async throws{
        do{
            try TikiSdk.config().initialize(publishingId: publishingId, id:id, onComplete: {
                Task{
                    do{
                        let offer = try Offer()
                            .id("randomId")
                            .bullet(text: "test 1", isUsed: true)
                            .bullet(text: "test 2", isUsed: false)
                            .bullet(text: "test 3", isUsed: true)
                            .ptr("source")
                            .description("testing")
                            .terms("terms")
                            .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                            .tag(TitleTag(TitleTagEnum.advertisingData))
                            .permission(Permission.camera)
                        let license = try await TikiSdk.license(
                            offer.ptr!, offer.uses, offer.terms ?? "terms", tags: offer.tags, licenseDescription: offer.description, expiry: offer.expiry)
                        XCTAssertEqual(license.description, "testing")
                        XCTAssertEqual(license.uses[0].usecases[0].value, LicenseUsecase(LicenseUsecaseEnum.support).value)
                        XCTAssertEqual(license.title.tags[0].value, TitleTagEnum.advertisingData.rawValue)
                    }catch{
                        XCTFail()
                    }
                }
            })
        }catch{
            XCTFail()
        }
    }
    
    func testGuard() async throws{
        do{
            try TikiSdk.config().initialize(publishingId: publishingId, id:id)
            let offer = try Offer()
                .id("randomId")
                .bullet(text: "test 1", isUsed: true)
                .bullet(text: "test 2", isUsed: false)
                .bullet(text: "test 3", isUsed: true)
                .ptr("source")
                .description("testing")
                .terms("terms")
                .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
                .tag(TitleTag(TitleTagEnum.advertisingData))
                .permission(Permission.camera)
            let _ = try await license(offer: offer)
            let guardResult = try await TikiSdk.guard(ptr: "source", usecases:[LicenseUsecase(LicenseUsecaseEnum.support)], destinations: [])
            XCTAssert(guardResult)
        }catch{
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
}

func license(offer: Offer) async throws -> LicenseRecord {
    return try await TikiSdk.license( offer.ptr!, offer.uses, offer.terms!, tags: offer.tags, licenseDescription: offer.description,expiry: offer.expiry)
}
