/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqReceiptAll: Req {
    public var payableId: String
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "payableId": payableId,
            "requestId": requestId
        ]
    }
}
