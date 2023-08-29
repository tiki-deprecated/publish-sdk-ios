/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspIsInitialized: Rsp {
    public let isInitialized: Bool
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.requestId = from["requestId"] as! String
        self.isInitialized = from["isInitialized"] as! Bool
    }
}
