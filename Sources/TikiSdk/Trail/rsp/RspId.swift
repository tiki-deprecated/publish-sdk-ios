/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspId: Rsp {
    let id: String?
    let requestId: String
    
    init(from: [String : Any?]) {
        self.id = from["id"] as? String
        self.requestId = from["requestId"] as! String
    }
}
