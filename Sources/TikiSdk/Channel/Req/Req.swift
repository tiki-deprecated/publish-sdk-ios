/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public protocol Req{
    var requestId: String { get }
    func asDictionary() -> [String: Any?]
}
