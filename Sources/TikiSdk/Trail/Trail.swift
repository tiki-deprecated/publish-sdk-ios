//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct Trail {
    private let channel: Channel
    let title: Title
    let license: License
    let payable: Payable
    let receipt: Receipt
    
    init(channel: Channel) {
        self.channel = channel
        self.title = Title(channel: channel)
        self.license = License(channel: channel)
        self.payable = Payable(channel: channel)
        self.receipt = Receipt(channel: channel)
    }
    
    func isInitialized(completion: @escaping (Result<Bool, Error>) -> Void) {
        channel.request(
            TrailMethod.IS_INITIALIZED,
            ReqDefault()
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspIsInitialized = try RspIsInitialized.from(args)
                    completion(.success(rsp.isInitialized))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func address(completion: @escaping (Result<String?, Error>) -> Void) {
        channel.request(
            TrailMethod.ADDRESS,
            ReqDefault()
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspAddress = try RspAddress.from(args)
                    completion(.success(rsp.address))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func id(completion: @escaping (Result<String?, Error>) -> Void) {
        channel.request(
            TrailMethod.ID,
            ReqDefault()
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspId = try RspId.from(args)
                    completion(.success(rsp.id))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func `guard`(
        ptr: String,
        usecases: [Usecase],
        destinations: [String]? = nil,
        onPass: (() -> Void)? = nil,
        onFail: ((String?) -> Void)? = nil,
        origin: String? = nil,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        channel.request(
            TrailMethod.GUARD,
            ReqGuard(ptr: ptr, usecases: usecases, destinations: destinations, origin: origin)
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspGuard = try RspGuard.from(args)
                    if let onPass = onPass, rsp.success {
                        onPass()
                    } else if let onFail = onFail, !rsp.success {
                        onFail(rsp.reason)
                    }
                    completion(.success(rsp.success))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
