/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

enum DefaultMethod: String, ChannelMethod {
    case INITIALIZE = "initialize"
    
    func value() -> String {
        return self.rawValue
    }
}
