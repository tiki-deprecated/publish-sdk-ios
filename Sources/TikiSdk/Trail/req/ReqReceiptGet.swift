/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqReceiptGet: Encodable, Req {
    var id: String
    var requestId: String?
}
