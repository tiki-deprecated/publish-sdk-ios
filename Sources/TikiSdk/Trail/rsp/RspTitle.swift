/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspTitle : Decodable, Rsp {
    let id: String?
    let hashedPtr: String?
    let origin: String?
    let tags: [Tag]?
    let description: String?
    var requestId: String?
}
