/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspPayables: Rsp {
    public let payables: [RspPayable]?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.payables = from["payables"] != nil ? (from["payables"] as! [[String: Any?]]).map{ payable in
            RspPayable(from: payable)
        } : nil
        self.requestId = from["requestId"] as! String
    }
}
