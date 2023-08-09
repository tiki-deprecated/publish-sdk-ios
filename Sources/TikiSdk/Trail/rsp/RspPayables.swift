/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspPayables: Decodable {
    let payables: [RspPayable]?
    let requestId: String?
}
