/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqPayable: Req {
    var licenseId: String
    var amount: String
    var type: String
    var expiry: Date? = nil
    var description: String? = nil
    var reference: String? = nil
    var requestId: String?
    
    func asDictionary() -> [String : Any?] {
        return [
            "licenseId": licenseId,
            "amount": amount,
            "type": type,
            "expiry": expiry ?? expiry!.millisecondsSinceEpoch(),
            "description": description,
            "reference": reference,
            "requestId": requestId,
        ]
    }
}
