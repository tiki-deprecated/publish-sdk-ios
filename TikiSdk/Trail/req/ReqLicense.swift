/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqLicense: Req {
    public var titleId: String
    public var uses: [Use]
    public var terms: String
    public var expiry: Date? = nil
    public var description: String? = nil
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "titleId": titleId,
            "uses": uses.map{ use in use.asDictionary() },
            "terms": terms,
            "expiry": expiry == nil ? nil : expiry!.millisecondsSinceEpoch(),
            "description": description,
            "requestId": requestId,
        ]
    }
        
}
