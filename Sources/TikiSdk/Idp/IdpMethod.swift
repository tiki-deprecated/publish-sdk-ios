/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

enum IdpMethod: String, ChannelMethod {
    case isInitialized = "idp.isInitialized"
    case key = "idp.key"
    case export = "idp.export"
    case importMethod = "idp.import"
    case sign = "idp.sign"
    case verify = "idp.verify"
    case token = "idp.token"
    
    func value() -> String {
        return self.rawValue
    }
}
