/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqPayableGet: Req {
    var id: String
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "id": id,
            "requestId": requestId
        ]
    }
}
