//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct ReqExport: Req, Encodable{
    var requestId: String?
    let keyId: String
    let `public`: Bool = false
}
