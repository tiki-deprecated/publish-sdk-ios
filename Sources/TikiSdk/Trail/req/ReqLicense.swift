/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqLicense: Req {
    var titleId: String
    var uses: [Use]
    var terms: String
    var expiry: Date? = nil
    var description: String? = nil
    var requestId: String?
    
    func asDictionary() -> [String : Any?] {
        return [
            "titleId": titleId,
            "uses": uses.map{ use in use.asDictionary() },
            "terms": terms,
            "expiry": expiry ?? expiry!.millisecondsSinceEpoch(),
            "description": description,
            "requestId": requestId,
        ]
    }
        
}
