/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspLicenses: Rsp {
    public let licenses: [RspLicense]?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.licenses = (from["licenses"] as? [[String: Any?]])?.map{ RspLicense(from: $0) }
        self.requestId = from["requestId"] as! String
    }
}

