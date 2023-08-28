/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicenseLatest: Req {
    var ptr: String
    var origin: String? = nil
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "ptr": ptr,
            "origin": origin,
            "requestId": requestId
        ]
    }
}
