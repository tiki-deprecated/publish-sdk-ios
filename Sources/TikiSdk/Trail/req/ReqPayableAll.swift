/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqPayableAll: Encodable, Req {
    var licenseId: String
    var requestId: String?
}