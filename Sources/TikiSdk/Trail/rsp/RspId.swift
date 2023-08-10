/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspId : Decodable, Rsp {
    let id: String?
    var requestId: String?
}
