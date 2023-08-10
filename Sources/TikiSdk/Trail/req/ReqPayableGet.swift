/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqPayableGet: Encodable, Req {
    var id: String
    var requestId: String?
}
