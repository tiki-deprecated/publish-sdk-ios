/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqTitleGet: Encodable, Req {
    var ptr: String
    var origin: String? = nil
    var requestId: String?
}
