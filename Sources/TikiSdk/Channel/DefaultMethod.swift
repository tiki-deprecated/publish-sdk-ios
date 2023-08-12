//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

enum DefaultMethod: String, ChannelMethod {
    case INITIALIZE = "initialize"
    
    func value() -> String {
        return self.rawValue
    }
}
