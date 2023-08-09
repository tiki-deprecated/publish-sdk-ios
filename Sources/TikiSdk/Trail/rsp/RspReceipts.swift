/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspReceipts : Decodable {
    let receipts: String?
    let requestId: String?
}
