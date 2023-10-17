/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public enum IdpMethod: String, ChannelMethod {
    case isInitialized = "idp.isInitialized"
    case key = "idp.key"
    case export = "idp.export"
    case importMethod = "idp.import"
    case sign = "idp.sign"
    case verify = "idp.verify"
    case token = "idp.token"
    
    public func value() -> String {
        return self.rawValue
    }
}
