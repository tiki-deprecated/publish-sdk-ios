/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspExport: Rsp {
    let key: String?
    let requestId: String
    
    init(from: [String : Any?]) {
        self.key = from["key"] as? String
        self.requestId = from["requestId"] as! String
    }
}
