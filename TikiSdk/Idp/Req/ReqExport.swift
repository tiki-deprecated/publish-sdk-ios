/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqExport: Req {
    public let keyId: String
    public let isPublic: Bool
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "keyId" : keyId,
            "public" : isPublic,
            "requestId" : requestId
        ]
    }
}
