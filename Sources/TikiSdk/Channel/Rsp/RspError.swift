/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import Foundation

struct RspError: Rsp, CustomStringConvertible {
    var requestId: String?
    
    let message: String?
    let stackTrace: String?
    
    init(message: String?, stackTrace: String?, requestId: String?) {
        self.message = message
        self.stackTrace = stackTrace
        self.requestId = requestId
    }
    
    static func from(map: [String: Any?]) -> RspError {
        return RspError(
            message: map["message"] as? String,
            stackTrace: map["stackTrace"] as? String,
            requestId: map["requestId"] as? String
        )
    }
    
    var description: String {
        return "RspError(message=\(message ?? "nil"), stackTrace=\(stackTrace ?? "nil"), requestId=\(requestId ?? "nil"))"
    }
}
