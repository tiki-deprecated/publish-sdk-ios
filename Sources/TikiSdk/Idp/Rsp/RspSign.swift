/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspSign: Rsp{
    public let signature: Data?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.signature = from["signature"] as? String != nil ? (from["signature"] as! String).data(using: .utf8) : nil
        self.requestId = from["requestId"] as! String
    }
}

