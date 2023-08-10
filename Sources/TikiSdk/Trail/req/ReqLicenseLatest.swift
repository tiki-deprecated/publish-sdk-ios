/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicenseLatest: Encodable, Req {
    var ptr: String
    var origin: String? = nil
    var requestId: String?
}
