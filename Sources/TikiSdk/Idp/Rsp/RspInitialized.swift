/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspInitialized: Rsp {
    let isInitialized: Bool
    var requestId: String?
    
    init(from: [String : Any?]) {
        self.isInitialized = from["isInitialized"] as! Bool
        self.requestId = from["requestId"] as? String
    }
}
