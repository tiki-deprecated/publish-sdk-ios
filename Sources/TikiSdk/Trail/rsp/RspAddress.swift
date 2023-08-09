/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspAdress : Decodable {
    let address: String
    let requestId: String?
}

