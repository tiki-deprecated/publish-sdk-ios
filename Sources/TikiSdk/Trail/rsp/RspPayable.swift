/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspPayable: Decodable, Rsp {
    let id: String?
    let license: RspLicense?
    let amount: String?
    let type: String?
    let description: String?
    let expiry: Date?
    let reference: String?
    var requestId: String?
}
