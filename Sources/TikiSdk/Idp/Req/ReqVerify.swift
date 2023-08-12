//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

import Foundation

struct ReqVerify: Req, Encodable, Equatable{
    var requestId: String?
    let keyId: String
    let message: Data
    let signature: Data
    
    enum CodingKeys: String, CodingKey {
        case keyId
        case message
        case signature
    }
    
    init(keyId: String, message: Data, signature: Data) {
        self.keyId = keyId
        self.message = message
        self.signature = signature
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(keyId, forKey: .keyId)
        try container.encode(message.base64EncodedString(), forKey: .message)
        try container.encode(signature.base64EncodedString(), forKey: .signature)
    }
    
    static func == (lhs: ReqVerify, rhs: ReqVerify) -> Bool {
        return lhs.keyId == rhs.keyId && lhs.message == rhs.message && lhs.signature == rhs.signature
    }
}
