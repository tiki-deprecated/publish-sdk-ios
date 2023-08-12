/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspDefault: Rsp, Decodable {
    let requestId: String?
}
