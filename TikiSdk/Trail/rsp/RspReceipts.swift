/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspReceipts: Rsp {
    public let receipts: [RspReceipt]?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.requestId = from["requestId"] as! String
        self.receipts = from["receipts"] as? [[String: Any?]] != nil ? (from["receipts"] as! [[String: Any?]]).map{ receipt in
            RspReceipt(from: receipt)
        } : nil
    }
}

