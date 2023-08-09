/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspInitialized : Decodable {
    let isInitialized: String
    let requestId: String?
}
