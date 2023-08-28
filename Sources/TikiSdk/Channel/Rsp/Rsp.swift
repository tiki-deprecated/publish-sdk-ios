/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public protocol Rsp {
    var requestId: String { get }
    init(from: [String:Any?])
}
