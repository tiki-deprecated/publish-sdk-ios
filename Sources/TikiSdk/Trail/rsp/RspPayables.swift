/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspPayables: Decodable, Rsp {
    let payables: [RspPayable]?
    var requestId: String?
}
