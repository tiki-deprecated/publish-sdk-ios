/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqImport: Req {
    public let keyId: String
    public let key: Data
    public var isPublic: Bool = false
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "keyId": keyId,
            "key": key.base64EncodedString(),
            "public": isPublic,
            "requestId": requestId
        ]
    }
}
