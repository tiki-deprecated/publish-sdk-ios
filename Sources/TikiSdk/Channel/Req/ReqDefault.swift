/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqDefault: Req {
    
    var requestId: String?
    
    func asDictionary() -> [String : Any?] {
        return [
            "requestId" : requestId
        ]
    }

}
