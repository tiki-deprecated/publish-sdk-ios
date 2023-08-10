/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqTitleId: Encodable, Req {
    var id: String
    var requestId: String?
}
