/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspReceipts : Decodable {
    let receipts: [RspReceipt]?
    let requestId: String?
}

