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
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        let receipt: ReceiptRecord = try await TikiSdk.instance.trail.receipt.create(payableId: payable!.id, amount: "10")!
        XCTAssertNotNil(receipt.id)
    }
    func testCreateNewTitle() async throws {
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        XCTAssertNotNil(title)
    }
    func testCreateDuplicatedTitleError() async throws {
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title1 = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        do {
            let title2 = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
            XCTFail()

        }catch {
            XCTAssertTrue(true)
        }
    }
    func testGetTitle() async throws {
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let createdTitle = try await TikiSdk.instance.trail.title.get(ptr: ptr)
        XCTAssertEqual(title?.id, createdTitle?.id)
        XCTAssertEqual(title?.description, createdTitle?.description)
        XCTAssertEqual(title?.hashedPtr, createdTitle?.hashedPtr)
        XCTAssertEqual(title?.origin, createdTitle?.origin)
    }
    
    func testCreateNewLicense() async throws{
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        XCTAssertNotNil(license?.id)

    }
    func testGetLicense() async throws{
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        let licenseCreated = try await TikiSdk.instance.trail.license.get(id: (license?.id)!)
        XCTAssertEqual(license?.id, licenseCreated?.id)
        XCTAssertEqual(license?.description, licenseCreated?.description)
        XCTAssertEqual(license?.expiry, licenseCreated?.expiry)
        XCTAssertEqual(license?.terms, licenseCreated?.terms)
        XCTAssertEqual(license?.title.id, licenseCreated?.title.id)
    }
    func testCreatePayable() async throws{
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        XCTAssertNotNil(payable?.id)

    }
    func testGetPayable() async throws{
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        let payableCreated = try await TikiSdk.instance.trail.payable.get(id: payable!.id)
        XCTAssertEqual(payable?.id, payableCreated?.id)
        XCTAssertEqual(payable?.amount, payableCreated?.amount)
        XCTAssertEqual(payable?.description, payableCreated?.description)
        XCTAssertEqual(payable?.expiry, payableCreated?.expiry)
        XCTAssertEqual(payable?.reference, payableCreated?.reference)
        XCTAssertEqual(payable?.type, payableCreated?.type)
        XCTAssertEqual(payable?.license.id, payableCreated?.license.id)
    }
    func testCreateNewReceipt() async throws {
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        let receipt: ReceiptRecord = try await TikiSdk.instance.trail.receipt.create(payableId: payable!.id, amount: "10")!
        XCTAssertNotNil(receipt.id)
    }
    func testGetReceipt() async throws {
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        let receipt: ReceiptRecord = try await TikiSdk.instance.trail.receipt.create(payableId: payable!.id, amount: "10")!
        let receiptCreated = try await TikiSdk.instance.trail.receipt.get(id: receipt.id)
        XCTAssertEqual(receipt.id, receiptCreated?.id)
        XCTAssertEqual(receipt.amount, receiptCreated?.amount)
        XCTAssertEqual(receipt.description, receiptCreated?.description)
        XCTAssertEqual(receipt.reference, receiptCreated?.reference)
        XCTAssertEqual(receipt.payable.id, receiptCreated?.payable.id)
    }
    func testIdpExport() async throws{
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        let receipt: ReceiptRecord = try await TikiSdk.instance.trail.receipt.create(payableId: payable!.id, amount: "10")!
        try await TikiSdk.instance.idp.export(keyId: id, completion: { rspExport in XCTAssertNotNil(rspExport)})

    }
    func testIdpToken() async throws {
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        let receipt: ReceiptRecord = try await TikiSdk.instance.trail.receipt.create(payableId: payable!.id, amount: "10")!
        try await TikiSdk.instance.idp.token(completion: { token in XCTAssertNotNil(token)})
    }
    func testTrailIsInitialized() async throws{
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let isInitialized = try await TikiSdk.instance.trail.isInitialized()
        XCTAssertTrue(isInitialized)
    }
    func testTrailAddress() async throws {
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let address = try await TikiSdk.instance.trail.address()
        XCTAssertNotNil(address)
    }
    func testIdpId() async throws {
        let id = UUID().uuidString
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let idTrail = try await TikiSdk.instance.trail.id()
        XCTAssertNotNil(idTrail)
    }
}
