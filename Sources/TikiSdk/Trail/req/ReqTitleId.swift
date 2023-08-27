/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqTitleId: Req {
    var id: String
    var requestId: String?
    
    func asDictionary() -> [String : Any?] {
        return [
            "id": id,
            "requestId": requestId
        ]
    }
}
