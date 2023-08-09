/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspIsInitialized : Decodable {
    let isInitialized: Bool
    let requestId: String?
}
