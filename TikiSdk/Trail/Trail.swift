/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct Trail {
    private let channel: Channel
    public let title: Title
    public let license: License
    public let payable: Payable
    public let receipt: Receipt
    
    public init(channel: Channel) {
        self.channel = channel
        self.title = Title(channel: channel)
        self.license = License(channel: channel)
        self.payable = Payable(channel: channel)
        self.receipt = Receipt(channel: channel)
    }
    
    public func isInitialized(completion: ((Bool) -> Void)? = nil) async throws -> Bool {
        let rspIsInitialized = try await channel.request(
            method: TrailMethod.IS_INITIALIZED,
            request: ReqDefault()
        ) { rsp in
            RspIsInitialized(from: rsp)
        }
        completion?(rspIsInitialized.isInitialized)
        return rspIsInitialized.isInitialized
    }
    
    public func address(completion: ((String) -> Void)? = nil) async throws -> String {
        let rspAddress = try await channel.request(
            method: TrailMethod.ADDRESS,
            request: ReqDefault()
        ) { rsp in
            RspAdress(from: rsp)
        }
        completion?(rspAddress.address)
        return rspAddress.address
    }
    
    public func id(completion: ((String?) -> Void)? = nil) async throws -> String? {
        let rspId = try await channel.request(
            method: TrailMethod.ID,
            request: ReqDefault()
        ) { rsp in
            RspId(from: rsp)
        }
        completion?(rspId.id)
        return rspId.id
    }
    
    public func `guard`(
        ptr: String,
        usecases: [Usecase],
        destinations: [String]? = nil,
        onPass: (() -> Void)? = nil,
        onFail: ((String?) -> Void)? = nil,
        origin: String? = nil
    ) async throws -> Bool{
        let reqGuard = ReqGuard(ptr: ptr, usercases: usecases, destinations: destinations, origin: origin ?? Bundle.main.bundleIdentifier!)
        let rspGuard = try await channel.request(
            method: TrailMethod.GUARD,
            request: reqGuard
        ) { rsp in
            RspGuard(from: rsp)
        }
        if let onPass = onPass, rspGuard.success {
            onPass()
        } else if let onFail = onFail, !rspGuard.success {
            onFail(rspGuard.reason)
        }
        return rspGuard.success
    }
}
