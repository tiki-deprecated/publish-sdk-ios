//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct ReqSign: Req, Encodable, Equatable{
    var requestId: String?
    let keyId: String?
    let message: Data
    
    enum CodingKeys: String, CodingKey {
       case keyId
       case message
    }
       
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(keyId, forKey: .keyId)
        let base64Message = message.base64EncodedString()
        try container.encode(base64Message, forKey: .message)
    }
    
   static func == (lhs: ReqSign, rhs: ReqSign) -> Bool {
       return lhs.keyId == rhs.keyId && lhs.message == rhs.message
   }
}
