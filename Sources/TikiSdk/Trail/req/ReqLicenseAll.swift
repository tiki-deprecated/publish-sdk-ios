/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicenseAll: Req {
    var titleId: String
    var requestId: String?
    
    func asDictionary() -> [String : Any?] {
        return [
            "titleId": titleId,
            "requestId": requestId
        ]
    }
}
