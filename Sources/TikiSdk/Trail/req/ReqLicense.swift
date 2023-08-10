/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicense : Encodable {
    var titleId: String
    var uses: [LicenseUse]
    var terms: String
    var expiry: Date? = nil
    var description: String? = nil
}
