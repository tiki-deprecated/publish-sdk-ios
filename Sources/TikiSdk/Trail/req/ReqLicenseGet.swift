/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicenseGet: Encodable, Req {
    var id: String
    var requestId: String?
}
