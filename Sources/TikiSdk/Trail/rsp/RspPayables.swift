/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspPayables: Rsp {
    let payables: [RspPayable]?
    let requestId: String
    
    init(from: [String : Any?]) {
        self.payables = from["payables"] != nil ? (from["payables"] as! [[String: Any?]]).map{ payable in
            RspPayable(from: payable)
        } : nil
        self.requestId = from["requestId"] as! String
    }
}
