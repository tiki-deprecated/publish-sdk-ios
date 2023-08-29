/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReqGuard: Req {
    public let requestId = UUID().uuidString
    public var ptr: String
    public var usercases: [Usecase]
    public var destinations: [String]? = nil
    public var origin: String
    
    public init(ptr: String, usercases: [Usecase], destinations: [String]? = nil, origin: String) {
        self.ptr = ptr
        self.usercases = usercases
        self.destinations = destinations
        self.origin = origin
    }
    
    public func asDictionary() -> [String : Any?] {
        return [
            "ptr": ptr,
            "usercases": usercases.map{ usecase in usecase.value },
            "destinations": destinations,
            "origin": origin,
        ]
    }
}
