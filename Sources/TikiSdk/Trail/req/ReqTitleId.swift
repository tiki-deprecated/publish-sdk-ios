/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqTitleId: Req {
    var id: String
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "id": id,
            "requestId": requestId
        ]
    }
}
