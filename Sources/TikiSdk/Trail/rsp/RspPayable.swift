/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspPayable: Rsp {
    let id: String?
    let license: RspLicense?
    let amount: String?
    let type: String?
    let description: String?
    let expiry: Date?
    let reference: String?
    let requestId: String
    
    init(from: [String : Any?]) {
        self.id = from["id"] as? String
        self.license = from["license"] as? [String: Any?] != nil ? RspLicense(from: (from["license"] as! [String: Any?])) : nil
        self.amount = from["amount"] as? String
        self.type = from["type"] as? String
        self.description = from["description"] as? String
        self.expiry = from["expiry"] as? Int64 != nil ? Date(milliseconds: from["expiry"] as! Int64) : nil
        self.reference = from["reference"] as? String
        self.requestId = from["requestId"] as! String
    }
}
