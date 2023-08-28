/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqImport: Req {
    let keyId: String
    let key: Data
    var isPublic: Bool = false
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "keyId": keyId,
            "key": key.base64EncodedString(),
            "public": isPublic,
            "requestId": requestId
        ]
    }
}
