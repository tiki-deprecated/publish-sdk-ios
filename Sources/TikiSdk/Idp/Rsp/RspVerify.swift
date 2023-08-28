/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspVerify: Rsp {
    let isVerified: Bool
    let requestId: String
    
    init(from: [String : Any?]) {
        self.isVerified = from["isVerified"] as! Bool
        self.requestId = from["requestId"] as! String
    }
}
