/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqSign: Req {
    public let requestId = UUID().uuidString
    public let keyId: String?
    public let message: Data
    
    public func asDictionary() -> [String : Any?] {
        return [
            "requestId" : requestId,
            "keyId" : keyId,
            "message" : message.base64EncodedString(),
        ]
    }
}
