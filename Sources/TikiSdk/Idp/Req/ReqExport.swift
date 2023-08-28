/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqExport: Req {
    let keyId: String
    let isPublic: Bool
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "keyId" : keyId,
            "public" : isPublic,
            "requestId" : requestId
        ]
    }
}
