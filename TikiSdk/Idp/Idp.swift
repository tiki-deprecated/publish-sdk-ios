/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The `Idp` class handles interactions with the Identity Provider.
public class Idp {
    private let channel: Channel
    
    /// Initializes the `Idp` class with a given communication channel.
    ///
    /// - Parameter channel: The communication channel to the Identity Provider.
    public init(channel: Channel) {
        self.channel = channel
    }
    
    /// Exports a key with the specified parameters.
    ///
    /// - Parameters:
    ///   - keyId: The ID of the key to export.
    ///   - isPublic: Indicates whether the key is public (default is false).
    ///   - completion: A closure to be called upon completion with the export response.
    /// - Throws: An error if the export operation fails.
    /// - Returns: The export response, `RspExport`.
    public func export(keyId: String, isPublic: Bool = false, completion: @escaping (RspExport) -> Void) async throws -> RspExport{
        let request = ReqExport(keyId: keyId, isPublic: isPublic)
        return try await channel.request(method: IdpMethod.export, request: request) { rsp in
            let rspExport = RspExport(from: rsp)
            completion(rspExport)
            return rspExport
        }
        
    }
    
    
    /// Imports a key with the specified parameters.
    ///
    /// - Parameters:
    ///   - keyId: The ID of the key to import.
    ///   - key: The key data to import.
    ///   - isPublic: Indicates whether the key is public (default is false).
    ///   - completion: A closure to be called upon completion with the import response.
    /// - Throws: An error if the import operation fails.
    /// - Returns: The import response, `RspDefault`.
    public func importMethod(keyId: String, key: Data, isPublic: Bool = false, completion: @escaping (RspDefault) -> Void) async throws -> RspDefault {
        let request = ReqImport(keyId: keyId, key: key, isPublic: isPublic)
        return try await channel.request(method: IdpMethod.importMethod, request: request) { rsp in
            let rspDefault = RspDefault(from: rsp)
            completion(rspDefault)
            return rspDefault
        }
    }
    
    /// Generates or retrieves a key with the specified parameters.
    ///
    /// - Parameters:
    ///   - keyId: The ID of the key to generate or retrieve.
    ///   - overwrite: Indicates whether to overwrite an existing key (default is false).
    ///   - completion: A closure to be called upon completion with the key response.
    /// - Throws: An error if the key operation fails.
    /// - Returns: The key response, `RspDefault`.
    public func key(keyId: String, overwrite: Bool = false, completion: @escaping (RspDefault) -> Void) async throws -> RspDefault{
        let request = ReqKey(keyId: keyId, overwrite: overwrite)
        return try await channel.request(method: IdpMethod.importMethod, request: request) { rsp in
            let rspDefault = RspDefault(from: rsp)
            completion(rspDefault)
            return rspDefault
        }
    }
    
    /// Signs a message with the specified key.
    ///
    /// - Parameters:
    ///   - keyId: The ID of the key to use for signing.
    ///   - message: The message data to sign.
    ///   - completion: A closure to be called upon completion with the signature data.
    /// - Throws: An error if the signing operation fails.
    /// - Returns: The signature data as `Data`, or `nil` if there is an error.
    public func sign(keyId: String, message: Data, completion: (Data?) -> Void) async throws -> Data? {
        let request = ReqSign(keyId: keyId, message: message)
        let rspSign = try await channel.request(method: IdpMethod.sign, request: request) { rsp in
            return RspSign(from: rsp)
        }
        let signature = rspSign.signature
        completion(signature)
        return signature
    }
    
    /// Verifies a message's signature using the specified key.
    ///
    /// - Parameters:
    ///   - keyId: The ID of the key to use for verification.
    ///   - message: The message data to verify.
    ///   - signature: The signature data to verify against.
    ///   - completion: A closure to be called upon completion with the verification result.
    /// - Throws: An error if the verification operation fails.
    /// - Returns: `true` if the message is verified, `false` otherwise.
    public func verify(keyId: String, message: Data, signature: Data, completion: (Bool) -> Void) async throws -> Bool {
        let request = ReqVerify(keyId: keyId, message: message, signature: signature)
        let rspVerify = try await channel.request(method: IdpMethod.verify, request: request) { rsp in
            RspVerify(from:rsp)
        }
        let isVerified = rspVerify.isVerified
        completion(isVerified)
        return isVerified
    }
    
    /// Retrieves a token from the Identity Provider.
    ///
    /// - Parameter completion: An optional closure to be called upon completion with the token.
    /// - Throws: An error if token retrieval fails.
    /// - Returns: The retrieved `Token`.
    public func token(completion: ((Token) -> Void)? = nil) async throws -> Token{
        let rspToken = try await channel.request(method: IdpMethod.token, request: ReqDefault()) { rsp in
            RspToken(from: rsp)
        }
        let token = Token(from: rspToken)
        completion?(token)
        return token
    }
}
