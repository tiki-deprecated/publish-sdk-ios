/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqPayableAll: Req {
    public var licenseId: String
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "licenseId": licenseId,
            "requestId": requestId
        ]
    }
}
