/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspSign: Rsp{
    let signature: Data?
    var requestId: String?
    
    init(from: [String : Any?]) {
        self.signature = from["signature"] as? String != nil ? (from["signature"] as! String).data(using: .utf8) : nil
        self.requestId = from["requestId"] as? String
    }
}

