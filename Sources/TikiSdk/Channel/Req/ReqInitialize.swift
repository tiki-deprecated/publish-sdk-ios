/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqInitialize: Req {
    let id: String
    let publishingId: String
    let origin: String
    let dir: String
    let requestId = UUID().uuidString
    
    func asDictionary() -> [String : Any?] {
        return [
            "id" : id,
            "publishingId" : publishingId,
            "origin" : origin,
            "dir" : dir,
            "requestId" : requestId,
        ]
    }
}
