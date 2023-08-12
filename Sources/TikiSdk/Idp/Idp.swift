//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

class Idp {
    private let channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
    }
    
    func export(keyId: String, isPublic: Bool = false, completion: @escaping (Result<String?, Error>) -> Void) {
        let request = ReqExport
        channel.request(method: IdpMethod.export, request: request) { args in
            RspExport.from(args)
        } completion: { result in
            switch result {
            case .success(let rsp):
                completion(.success(rsp.key))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func importMethod(keyId: String, key: [UInt8], public: Bool = false, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = ReqImport(keyId: keyId, key: key, public: `public`)
        channel.request(method: IdpMethod.importMethod, request: request) { args in
            RspDefault.from(args)
        } completion: { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func key(keyId: String, overwrite: Bool = false, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = ReqKey(keyId: keyId, overwrite: overwrite)
        channel.request(method: IdpMethod.key, request: request) { args in
            RspDefault.from(args)
        } completion: { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sign(keyId: String, message: [UInt8], completion: @escaping (Result<[UInt8]?, Error>) -> Void) {
        let request = ReqSign(keyId: keyId, message: message)
        channel.request(method: IdpMethod.sign, request: request) { args in
            RspSign.from(args)
        } completion: { result in
            switch result {
            case .success(let rsp):
                completion(.success(rsp.signature))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func verify(keyId: String, message: [UInt8], signature: [UInt8], completion: @escaping (Result<Bool, Error>) -> Void) {
        let request = ReqVerify(keyId: keyId, message: message, signature: signature)
        channel.request(method: IdpMethod.verify, request: request) { args in
            RspVerify.from(args)
        } completion: { result in
            switch result {
            case .success(let rsp):
                completion(.success(rsp.isVerified))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func token(completion: @escaping (Result<Token, Error>) -> Void) {
        let request = ReqDefault()
        channel.request(method: IdpMethod.token, request: request) { args in
            RspToken.from(args)
        } completion: { result in
            switch result {
            case .success(let rsp):
                completion(.success(Token.from(rsp)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
