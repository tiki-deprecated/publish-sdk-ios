/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspDefault: Rsp {
    let requestId: String
    
    init(from: [String : Any?]) {
        self.requestId = from["requestId"] as! String
    }
}
