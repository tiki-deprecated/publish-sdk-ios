//
//  File.swift
//  
//
//  Created by Ricardo on 18/11/22.
//

import Foundation

public struct TikiSdkError : Error {

    var message: String?

    init(message: String?){
        self.message = message
    }
}
