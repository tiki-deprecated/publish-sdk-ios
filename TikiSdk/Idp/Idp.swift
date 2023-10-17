/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public class Idp {
    private let channel: Channel
    
    public init(channel: Channel) {
        self.channel = channel
    }
    
    public func export(keyId: String, isPublic: Bool = false, completion: @escaping (RspExport) -> Void) async throws -> RspExport{
        let request = ReqExport(keyId: keyId, isPublic: isPublic)
        return try await channel.request(method: IdpMethod.export, request: request) { rsp in
            let rspExport = RspExport(from: rsp)
            completion(rspExport)
            return rspExport
        }
        
    }
    
    public func importMethod(keyId: String, key: Data, isPublic: Bool = false, completion: @escaping (RspDefault) -> Void) async throws -> RspDefault {
        let request = ReqImport(keyId: keyId, key: key, isPublic: isPublic)
        return try await channel.request(method: IdpMethod.importMethod, request: request) { rsp in
            let rspDefault = RspDefault(from: rsp)
            completion(rspDefault)
            return rspDefault
        }
    }
    
    public func key(keyId: String, overwrite: Bool = false, completion: @escaping (RspDefault) -> Void) async throws -> RspDefault{
        let request = ReqKey(keyId: keyId, overwrite: overwrite)
        return try await channel.request(method: IdpMethod.importMethod, request: request) { rsp in
            let rspDefault = RspDefault(from: rsp)
            completion(rspDefault)
            return rspDefault
        }
    }
    
    public func sign(keyId: String, message: Data, completion: (Data?) -> Void) async throws -> Data? {
        let request = ReqSign(keyId: keyId, message: message)
        let rspSign = try await channel.request(method: IdpMethod.sign, request: request) { rsp in
            return RspSign(from: rsp)
        }
        let signature = rspSign.signature
        completion(signature)
        return signature
    }
    
    public func verify(keyId: String, message: Data, signature: Data, completion: (Bool) -> Void) async throws -> Bool {
        let request = ReqVerify(keyId: keyId, message: message, signature: signature)
        let rspVerify = try await channel.request(method: IdpMethod.verify, request: request) { rsp in
            RspVerify(from:rsp)
        }
        let isVerified = rspVerify.isVerified
        completion(isVerified)
        return isVerified
    }
    
    public func token(completion: ((Token) -> Void)? = nil) async throws -> Token{
        let rspToken = try await channel.request(method: IdpMethod.token, request: ReqDefault()) { rsp in
            RspToken(from: rsp)
        }
        let token = Token(from: rspToken)
        completion?(token)
        return token
    }
}
