/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqVerify: Req {
    public let requestId = UUID().uuidString
    public let keyId: String
    public let message: Data
    public let signature: Data
    
    public func asDictionary() -> [String : Any?] {
        return [
            "requestId": requestId,
            "keyId": keyId,
            "message": message.base64EncodedString(),
            "signature": signature.base64EncodedString()
        ]
    }
}
