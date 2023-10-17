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
}
