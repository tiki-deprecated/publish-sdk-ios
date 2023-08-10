/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspLicense : Decodable, Rsp {
    let id: String?
    let title: RspTitle?
    let uses: [LicenseUse]?
    let terms: String?
    let description: String?
    let expiry: Date?
    var requestId: String?
}
