/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqDefault: Req {
    var requestId: String?
    
    init(requestId: String?) {
        self.requestId = requestId
    }
    
    static func from(map: [String: Any?]) -> ReqDefault {
        return ReqDefault(
            requestId: map["requestId"] as? String
        )
    }
}
