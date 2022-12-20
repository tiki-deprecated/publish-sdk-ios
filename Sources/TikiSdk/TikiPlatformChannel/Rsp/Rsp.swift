/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

protocol Rsp : Decodable {
    var requestId : String { get }
}
