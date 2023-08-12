//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct RspSign: Codable, Equatable {
    let signature: [UInt8]?
    let requestId: String?
    
    enum CodingKeys: String, CodingKey {
        case signature
        case requestId
    }
    
    static func == (lhs: RspSign, rhs: RspSign) -> Bool {
        if let lhsSignature = lhs.signature, let rhsSignature = rhs.signature {
            if lhsSignature != rhsSignature {
                return false
            }
        } else if lhs.signature != nil || rhs.signature != nil {
            return false
        }
        
        return lhs.requestId == rhs.requestId
    }
    
    static func from(map: [String: Any?]) -> RspSign? {
        if let b64Sig = map["signature"] as? String {
            let signature = Data(base64Encoded: b64Sig)?.map { UInt8($0) }
            return RspSign(signature: signature, requestId: map["requestId"] as? String)
        }
        return nil
    }
}

