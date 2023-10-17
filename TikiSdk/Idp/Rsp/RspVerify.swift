/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspVerify: Rsp {
    public let isVerified: Bool
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.isVerified = from["isVerified"] as! Bool
        self.requestId = from["requestId"] as! String
    }
}
