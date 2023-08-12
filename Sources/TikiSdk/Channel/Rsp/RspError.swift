/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import Foundation

struct RspError: Rsp, Decodable {
    let message: String?
    let stackTrace: String?
    var requestId: String?
    var description: String {
        return "RspError(message=\(message ?? "nil"), stackTrace=\(stackTrace ?? "nil"), requestId=\(requestId ?? "nil"))"
    }
}
