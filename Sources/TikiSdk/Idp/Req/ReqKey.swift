//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct ReqKey: Encodable{
    var requestId: String?
    let keyId: String
    let overwrite: Bool
}
