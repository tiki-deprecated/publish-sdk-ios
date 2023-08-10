/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspDefault: Rsp {
    var requestId: String?
    
    init(requestId: String?) {
        self.requestId = requestId
    }
    
    static func from(map: [String: Any?]) -> RspDefault {
        return RspDefault(
            requestId: map["requestId"] as? String
        )
    }
}
