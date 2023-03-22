/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicense: Encodable {
    var ptr: String?
    var terms: String?
    var titleDescription: String?
    var licenseDescription: String?
    var uses: [LicenseUse] = []
    var tags: [TitleTag] = []
    var expiry: Date?
    var origin: String?
}
