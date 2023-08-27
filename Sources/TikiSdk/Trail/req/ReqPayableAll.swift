/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqPayableAll: Req {
    var licenseId: String
    var requestId: String?
    
    func asDictionary() -> [String : Any?] {
        return [
            "licenseId": licenseId,
            "requestId": requestId
        ]
    }
}
