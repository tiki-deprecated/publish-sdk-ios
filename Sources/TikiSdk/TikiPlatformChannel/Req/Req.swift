/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation

/// The base Request object for native channels.
///
/// The *requestId* parameter is used to identify the request in the native platform.
public protocol Req : Encodable {
    func toJSONData() -> Data?
}

public extension Req {
    func toJSONData() -> Data?{ try? JSONEncoder().encode(self) }
}
