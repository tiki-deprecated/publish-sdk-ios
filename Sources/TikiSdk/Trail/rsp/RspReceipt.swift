/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspReceipt: Decodable, Rsp {
    let id: String?
    let payable: RspPayable?
    let amount: String?
    let description: String?
    let reference: String?
    var requestId: String?
}
