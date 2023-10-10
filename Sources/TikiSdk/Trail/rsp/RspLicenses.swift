/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspLicenses: Rsp {
    public let licenses: [RspLicense]?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        let licDict = RspLicenses.nullToNil(value: from["licenses"] as Any?) as? [[String: Any?]]
        self.licenses = licDict?.map{ dict in RspLicense.init(from: dict)}
        self.requestId = from["requestId"] as! String
    }
}
