/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspLicense: Rsp {
    public let id: String?
    public let title: RspTitle?
    public let uses: [Use]?
    public let terms: String?
    public let description: String?
    public let expiry: Date?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.requestId = from["requestId"] as! String
        self.id = from["id"] as? String
        self.title = from["title"] != nil ? RspTitle(from: from["title"] as! [String: Any?]) : nil
        self.uses = (from["uses"] as! [[String: [String]]]).map{ use in Use(from: use as [String: [String]]) } as [Use]
        self.terms = from["terms"] as? String
        self.description = from["description"] as? String
        self.expiry = from["expiry"] != nil ? Date(milliseconds: from["expiry"] as! Int64) : nil
    }
}
