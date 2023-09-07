/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspReceipt: Rsp {
    public let id: String?
    public let payable: RspPayable?
    public let amount: String?
    public let description: String?
    public let reference: String?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.id = from["id"] as? String
        self.payable = from["payable"] as? [String: Any?] != nil ? RspPayable(from: from["payable"] as! [String: Any?]) : nil
        self.amount = from["amount"] as? String
        self.description = from["description"] as? String
        self.reference = from["reference"] as? String
        self.requestId = from["requestId"] as! String
    }
}
