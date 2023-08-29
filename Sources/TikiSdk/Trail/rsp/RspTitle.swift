/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspTitle: Rsp {
    public let id: String?
    public let hashedPtr: String?
    public let origin: String?
    public let tags: [Tag]?
    public let description: String?
    public let requestId: String
    
    public init(from: [ String: Any? ]){
        self.id = from["id"] as? String
        self.hashedPtr = from["hashedPtr"] as? String
        self.origin = from["origin"] as? String
        self.tags = from["tags"] != nil ? (from["tags"] as! [String]).map{ tagValue in Tag.from(tag: tagValue) } : nil
        self.description = from["description"] as? String
        self.requestId = from["requestId"] as! String
    }
}
