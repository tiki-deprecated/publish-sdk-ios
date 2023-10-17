/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqDefault: Req {
    
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "requestId" : requestId
        ]
    }

}
