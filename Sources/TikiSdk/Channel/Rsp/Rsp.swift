/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

protocol Rsp {
    var requestId: String { get }
    init(from: [String:Any?])
    
}

extension Rsp{
    static func nullToNil(value : Any?) -> Any? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
}
