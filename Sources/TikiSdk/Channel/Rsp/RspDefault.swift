/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspDefault: Rsp {
    var requestId: String?
    
    init(from: [String : Any?]) {
        self.requestId = from["requestId"] as? String
    }
}
