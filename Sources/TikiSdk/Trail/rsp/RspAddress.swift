/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspAdress : Decodable, Rsp {
    let address: String
    var requestId: String?
}
