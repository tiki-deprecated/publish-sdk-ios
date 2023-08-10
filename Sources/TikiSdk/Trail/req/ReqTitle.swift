/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqTitle: Encodable, Req {
    var ptr: String
    var tags: [Tag]
    var description: String? = nil
    var origin: String? = nil
    var requestId: String?
}
