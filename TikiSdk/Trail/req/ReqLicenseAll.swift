/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqLicenseAll: Req {
    public var titleId: String
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "titleId": titleId,
            "requestId": requestId
        ]
    }
}
