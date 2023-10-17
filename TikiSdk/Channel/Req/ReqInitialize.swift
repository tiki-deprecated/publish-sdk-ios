/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqInitialize: Req {
    let id: String
    let publishingId: String
    let origin: String
    let dir: String
    public let requestId = UUID().uuidString
    
    public func asDictionary() -> [String : Any?] {
        return [
            "id" : id,
            "publishingId" : publishingId,
            "origin" : origin,
            "dir" : dir,
            "requestId" : requestId,
        ]
    }
}
