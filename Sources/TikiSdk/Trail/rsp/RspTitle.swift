/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspTitle: Rsp {
    let id: String?
    let hashedPtr: String?
    let origin: String?
    let tags: [Tag]?
    let description: String?
    var requestId: String?
    
    init(from: [ String: Any? ]){
        self.id = from["id"] as? String
        self.hashedPtr = from["hashedPtr"] as? String
        self.origin = from["origin"] as? String
        self.tags = from["tags"] != nil ? (from["tags"] as! [String]).map{ tagValue in Tag.from(tag: tagValue) } : nil
        self.description = from["description"] as? String
        self.requestId = from["requestId"] as? String
    }
}
