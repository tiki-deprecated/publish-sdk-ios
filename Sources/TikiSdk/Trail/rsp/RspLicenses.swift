/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspLicenses: Decodable, Rsp {
    let licenses: [RspLicense]?
    var requestId: String?
}

