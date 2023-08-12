/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import Foundation

struct RspError: Rsp, Decodable {
    let requestId: String?
    let message: String?
    let stackTrace: String?
    
    var description: String {
        return "RspError(message=\(message ?? "nil"), stackTrace=\(stackTrace ?? "nil"), requestId=\(requestId ?? "nil"))"
    }
}
