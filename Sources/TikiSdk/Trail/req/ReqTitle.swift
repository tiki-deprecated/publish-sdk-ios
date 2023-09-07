/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqTitle: Req {
    public var ptr: String
    public var tags: [Tag]
    public var description: String? = nil
    public var origin: String? = nil
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "ptr": ptr,
            "tags": tags.map{ tag in tag.value },
            "description": description,
            "origin": origin,
            "requestId": requestId
        ]
    }
}
