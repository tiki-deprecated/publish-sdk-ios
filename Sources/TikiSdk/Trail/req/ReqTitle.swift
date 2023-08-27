/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqTitle: Req {
    var ptr: String
    var tags: [Tag]
    var description: String? = nil
    var origin: String? = nil
    var requestId: String?
    
    func asDictionary() -> [String : Any?] {
        return [
            "ptr": ptr,
            "tags": tags.map{ tag in tag.value },
            "description": description,
            "origin": origin,
            "requestId": requestId
        ]
    }
}
