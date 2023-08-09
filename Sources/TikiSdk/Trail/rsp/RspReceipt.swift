/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspReceipt: Decodable {
    let id: String?
    let payable: RspPayable?
    let amount: String?
    let description: String?
    let reference: String?
    let requestId: String?
}
