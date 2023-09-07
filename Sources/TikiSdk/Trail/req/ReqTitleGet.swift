/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqTitleGet: Req {
    public var ptr: String
    public var origin: String? = nil
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "ptr": ptr,
            "origin": origin,
            "requestId": requestId
        ]
    }
}
