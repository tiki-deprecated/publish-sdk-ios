//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

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
