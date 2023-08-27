/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqVerify: Req {
    var requestId: String?
    let keyId: String
    let message: Data
    let signature: Data
    
    func asDictionary() -> [String : Any?] {
        return [
            "requestId": requestId,
            "keyId": keyId,
            "message": message.base64EncodedString(),
            "signature": signature.base64EncodedString()
        ]
    }
}
