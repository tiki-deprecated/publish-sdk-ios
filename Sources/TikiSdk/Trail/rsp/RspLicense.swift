/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspLicense: Rsp {
    let id: String?
    let title: RspTitle?
    let uses: [Use]?
    let terms: String?
    let description: String?
    let expiry: Date?
    let requestId: String
    
    init(from: [String : Any?]) {
        self.requestId = from["requestId"] as! String
        self.id = from["id"] as? String
        self.title = from["title"] != nil ? RspTitle(from: from["title"] as! [String: Any?]) : nil
        self.uses = (from["uses"] as! [[String: [String]]]).map{ use in Use(from: use as [String: [String]]) } as [Use]
        self.terms = from["terms"] as? String
        self.description = from["description"] as? String
        self.expiry = from["expiry"] != nil ? Date(milliseconds: from["expiry"] as! Int64) : nil
    }
}
