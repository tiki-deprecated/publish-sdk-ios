/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

class Idp {
    private let channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
    }
    
    func export(keyId: String, isPublic: Bool = false, completion: @escaping (RspExport) -> Void) async throws -> RspExport{
        let request = ReqExport(keyId: keyId, isPublic: isPublic)
        return try await channel.request(method: IdpMethod.export, request: request) { rsp in
            let rspExport = RspExport(from: rsp)
            completion(rspExport)
            return rspExport
        }
        
    }
    
    func importMethod(keyId: String, key: Data, isPublic: Bool = false, completion: @escaping (Rsp) -> Void) async throws -> RspDefault {
        let request = ReqImport(keyId: keyId, key: key, isPublic: isPublic)
        return try await channel.request(method: IdpMethod.importMethod, request: request) { rsp in
            let rspDefault = RspDefault(from: rsp)
            completion(rspDefault)
            return rspDefault
        }
    }
    
    func key(keyId: String, overwrite: Bool = false, completion: @escaping (Rsp) -> Void) async throws -> RspDefault{
        let request = ReqKey(keyId: keyId, overwrite: overwrite)
        return try await channel.request(method: IdpMethod.importMethod, request: request) { rsp in
            let rspDefault = RspDefault(from: rsp)
            completion(rspDefault)
            return rspDefault
        }
    }
    
    func sign(keyId: String, message: Data, completion: (Data?) -> Void) async throws -> Data? {
        let request = ReqSign(keyId: keyId, message: message)
        let rspSign = try await channel.request(method: IdpMethod.sign, request: request) { rsp in
            return RspSign(from: rsp)
        }
        let signature = rspSign.signature
        completion(signature)
        return signature
    }
    
    func verify(keyId: String, message: Data, signature: Data, completion: (Bool) -> Void) async throws -> Bool {
        let request = ReqVerify(keyId: keyId, message: message, signature: signature)
        let rspVerify = try await channel.request(method: IdpMethod.verify, request: request) { rsp in
            RspVerify(from:rsp)
        }
        let isVerified = rspVerify.isVerified
        completion(isVerified)
        return isVerified
    }
    
    func token(completion: (Token) -> Void) async throws -> Token{
        let rspToken = try await channel.request(method: IdpMethod.token, request: ReqDefault()) { rsp in
            RspToken(from: rsp)
        }
        let token = Token(from: rspToken)
        completion(token)
        return token
    }
}
