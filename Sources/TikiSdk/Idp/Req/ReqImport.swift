//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct ReqImport: Encodable{
    var requestId: String?
    let keyId: String
    let key: UInt8
    let `public`: Bool = false
}
