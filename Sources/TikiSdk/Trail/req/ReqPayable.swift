/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqPayable: Req {
    public var licenseId: String
    public var amount: String
    public var type: String
    public var expiry: Date? = nil
    public var description: String? = nil
    public var reference: String? = nil
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "licenseId": licenseId,
            "amount": amount,
            "type": type,
            "expiry": expiry != nil ? expiry!.millisecondsSinceEpoch() : nil,
            "description": description,
            "reference": reference,
            "requestId": requestId,
        ]
    }
}
