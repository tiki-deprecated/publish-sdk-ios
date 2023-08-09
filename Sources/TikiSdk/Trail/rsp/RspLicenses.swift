/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspLicenses: Decodable {
    let licenses: [RspLicense]?
    let requestId: String?
}
