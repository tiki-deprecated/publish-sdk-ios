/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspGuard: Rsp {
    let success: Bool
    let reason: String?
    let requestId: String
    
    init(from: [String : Any?]) {
        self.success = from["success"] as! Bool
        self.reason = from["reason"] as? String
        self.requestId = from["requestId"] as! String
    }
}
