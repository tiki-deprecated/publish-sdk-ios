/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The base Response object for native channels.
///
/// The *requestId* parameter is used to identify the request in the native platform.
protocol Rsp : Decodable {
    var requestId : String { get }
}
