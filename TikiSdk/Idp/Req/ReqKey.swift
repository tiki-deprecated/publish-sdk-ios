/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqKey: Req {
    public let requestId = UUID().uuidString
    public let keyId: String
    public let overwrite: Bool
    
    public func asDictionary() -> [String : Any?] {
        return [
            "requestId": requestId,
            "keyId": keyId,
            "overwrite": overwrite,
        ]
    }
}
