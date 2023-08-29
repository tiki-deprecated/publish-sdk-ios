/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspError: Rsp {
    public let message: String?
    public let stackTrace: String?
    public let requestId: String
    public var description: String {
        return "RspError(message=\(message ?? "nil"), stackTrace=\(stackTrace ?? "nil"), requestId=\(requestId ))"
    }
    
    public init(from: [String : Any?]) {
        self.requestId = from["requestId"] as! String
        self.message = from["message"] as? String
        self.stackTrace = from["stackTrace"] as? String
    }
}
