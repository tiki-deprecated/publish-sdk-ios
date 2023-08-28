/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

protocol Rsp {
    var requestId: String? { get set }
    
    init(from: [String:Any?])
}
