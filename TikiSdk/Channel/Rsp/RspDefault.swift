/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspDefault: Rsp {
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.requestId = from["requestId"] as! String
    }
}
