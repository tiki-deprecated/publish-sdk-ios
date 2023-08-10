/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspInitialize : Decodable, Rsp {
    let id: String?
    let address: String?
    var requestId: String?

}
