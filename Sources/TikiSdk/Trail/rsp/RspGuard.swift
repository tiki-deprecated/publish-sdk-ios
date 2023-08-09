/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspGuard : Decodable {
    let success: Bool
    let reason: String?
    let requestId: String?
}

