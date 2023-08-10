/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicenseAll: Encodable, Req {
    var titleId: String
    var requestId: String?
}
