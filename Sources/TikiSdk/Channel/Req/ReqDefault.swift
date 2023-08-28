/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqDefault: Req {
    
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "requestId" : requestId
        ]
    }

}
