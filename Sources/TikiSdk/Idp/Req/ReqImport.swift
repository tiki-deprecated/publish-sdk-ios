/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqImport: Req {
    let keyId: String
    let key: Data
    let isPublic: Bool = false
    var requestId: String? = nil
    
    func asDictionary() -> [String : Any?] {
        return [
            "keyId": keyId,
            "key": key.base64EncodedString(),
            "public": isPublic,
            "requestId": requestId
        ]
    }
}
