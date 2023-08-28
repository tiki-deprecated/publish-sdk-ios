/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqReceipt: Req {
    var payableId: String
    var amount: String
    var description: String? = nil
    var reference: String? = nil
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "payableId": payableId,
            "amount": amount,
            "description": description,
            "reference": reference,
            "requestId": requestId
        ]
    }
}
