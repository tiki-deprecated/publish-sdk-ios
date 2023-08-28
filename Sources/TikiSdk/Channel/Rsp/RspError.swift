/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspError: Rsp {
    let message: String?
    let stackTrace: String?
    let requestId: String
    var description: String {
        return "RspError(message=\(message ?? "nil"), stackTrace=\(stackTrace ?? "nil"), requestId=\(requestId ))"
    }
    
    init(from: [String : Any?]) {
        self.requestId = from["requestId"] as! String
        self.message = from["message"] as? String
        self.stackTrace = from["stackTrace"] as? String
    }
}
