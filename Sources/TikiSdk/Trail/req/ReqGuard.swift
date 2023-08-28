/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqGuard: Req {
    let requestId = UUID().uuidString
    var ptr: String
    var usercases: [Usecase]
    var destinations: [String]? = nil
    var origin: String
    
    func asDictionary() -> [String : Any?] {
        return [
            "ptr": ptr,
            "usercases": usercases.map{ usecase in usecase.value },
            "destinations": destinations,
            "origin": origin,
        ]
    }
}
