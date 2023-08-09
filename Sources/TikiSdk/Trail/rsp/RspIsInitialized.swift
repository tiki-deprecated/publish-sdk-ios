/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspInitialized : Decodable {
    let address: String
    let requestId: String?
}
