/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspInitialized: Rsp {
    public let isInitialized: Bool
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.isInitialized = from["isInitialized"] as! Bool
        self.requestId = from["requestId"] as! String
    }
}
