/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqInitialize: Req, Encodable {
    let id: String
    let publishingId: String
    let origin: String
    let dir: String
    var requestId: String?
}
