/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspInitialized : Decodable, Rsp {
    let isInitialized: Bool
    var requestId: String?
}
