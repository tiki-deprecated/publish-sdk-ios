/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqError: Req, Error {
    var _domain: String
    
    var _code: Int
    
    var _userInfo: AnyObject?
    
    func _getEmbeddedNSError() -> AnyObject? {
        <#code#>
    }
    
    let message: String?
    let stackTrace: String?
    var requestId: String?
    
    init(message: String?, stackTrace: String?, requestId: String?) {
        self.message = message
        self.stackTrace = stackTrace
        self.requestId = requestId
    }
    
    static func from(map: [String: Any?]) -> Error {
        return ReqError(
            message: map["message"] as? String,
            stackTrace: map["stackTrace"] as? String,
            requestId: map["requestId"] as? String
        )
    }
    
    var description: String {
        return "reqError(message: \(message ?? "nil"), stackTrace: \(stackTrace ?? "nil"), requestId: \(requestId ?? "nil"))"
    }
}
