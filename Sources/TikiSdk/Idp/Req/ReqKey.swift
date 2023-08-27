/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqKey: Req {
    var requestId: String?
    let keyId: String
    let overwrite: Bool
    
    func asDictionary() -> [String : Any?] {
        return [
            "requestId": requestId,
            "keyId": keyId,
            "overwrite": overwrite,
        ]
    }
}
