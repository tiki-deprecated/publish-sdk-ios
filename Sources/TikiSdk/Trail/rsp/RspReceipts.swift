/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspReceipts : Decodable, Rsp {
    let receipts: [RspReceipt]?
    var requestId: String?
}

