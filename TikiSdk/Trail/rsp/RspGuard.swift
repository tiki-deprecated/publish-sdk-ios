/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspGuard: Rsp {
    public let success: Bool
    public let reason: String?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.success = from["success"] as! Bool
        self.reason = from["reason"] as? String
        self.requestId = from["requestId"] as! String
    }
}
