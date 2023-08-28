/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspIsInitialized: Rsp {
    let isInitialized: Bool
    var requestId: String?
    
    init(from: [String : Any?]) {
        self.requestId = from["requestId"] as? String
        self.isInitialized = from["isInitialized"] as! Bool
    }
}
