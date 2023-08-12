/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqReceiptAll: Encodable, Req {
    var payableId: String
    var requestId: String?
}
