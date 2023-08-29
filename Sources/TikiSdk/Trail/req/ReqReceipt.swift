/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqReceipt: Req {
    public var payableId: String
    public var amount: String
    public var description: String? = nil
    public var reference: String? = nil
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "payableId": payableId,
            "amount": amount,
            "description": description,
            "reference": reference,
            "requestId": requestId
        ]
    }
}
