/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspInitialize: Rsp {
    public let id: String?
    public let address: String?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.id = from["id"] as? String
        self.address = from["address"] as? String
        self.requestId = from["requestId"] as! String
    }

}
