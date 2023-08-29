/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspExport: Rsp {
    public let key: String?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.key = from["key"] as? String
        self.requestId = from["requestId"] as! String
    }
}
