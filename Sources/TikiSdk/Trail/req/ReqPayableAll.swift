/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqPayableAll: Req {
    var licenseId: String
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "licenseId": licenseId,
            "requestId": requestId
        ]
    }
}
