/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspReceipt: Rsp {
    let id: String?
    let payable: RspPayable?
    let amount: String?
    let description: String?
    let reference: String?
    var requestId: String?
    
    
    init(from: [String : Any?]) {
        self.id = from["id"] as? String
        self.payable = from["payable"] as? [String: Any?] != nil ? RspPayable(from: from["payable"] as! [String: Any?]) : nil
        self.amount = from["amount"] as? String
        self.description = from["description"] as? String
        self.reference = from["reference"] as? String
        self.requestId = from["requestId"] as? String
    }
}
