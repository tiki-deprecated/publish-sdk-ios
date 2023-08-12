/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicense : Encodable, Req {
    var titleId: String
    var uses: [Use]
    var terms: String
    var expiry: Date? = nil
    var description: String? = nil
    var requestId: String?
}
