/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspGuard : Decodable, Rsp {
    let success: Bool
    let reason: String?
    var requestId: String?
}
