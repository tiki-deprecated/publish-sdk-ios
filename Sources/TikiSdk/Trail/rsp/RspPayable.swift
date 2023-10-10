/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspPayable: Rsp {
    public let id: String?
    public let license: RspLicense?
    public let amount: String?
    public let type: String?
    public let description: String?
    public let expiry: Date?
    public let reference: String?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.id = from["id"] as? String
        self.license = from["license"] as? [String: Any?] != nil ? RspLicense(from: (from["license"] as! [String: Any?])) : nil
        self.amount = from["amount"] as? String
        self.type = from["type"] as? String
        self.description = from["description"] as? String
        self.expiry = from["expiry"] as? Int64 != nil ? Date(milliseconds: from["expiry"] as! Int64) : nil
        self.reference = from["reference"] as? String
        self.requestId = RspPayable.nullToNil(value: from["requestId"]) != nil ? from["requestId"] as! String : ""
    }
}
