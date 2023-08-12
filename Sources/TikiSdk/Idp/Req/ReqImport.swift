//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct ReqImport: Req, Encodable, Equatable{
    let keyId: String
    let key: Data
    var requestId: String? = nil
    let `public`: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case keyId
        case key
        case `public`
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(keyId, forKey: .keyId)
        try container.encode(key.base64EncodedString(), forKey: .key)
        try container.encode(`public`, forKey: .public)
    }
    
    static func == (lhs: ReqImport, rhs: ReqImport) -> Bool {
        return lhs.keyId == rhs.keyId && lhs.key == rhs.key && lhs.public == rhs.public
    }
}
