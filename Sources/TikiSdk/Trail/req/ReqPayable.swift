/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqPayable: Encodable {
    var licenseId: String
    var amount: String
    var type: String
    var expiry: Date? = nil
    var description: String? = nil
    var reference: String? = nil
}
