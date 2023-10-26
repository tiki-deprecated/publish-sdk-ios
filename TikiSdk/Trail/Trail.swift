/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The Trail struct handles interactions with the blockchain.
public struct Trail {
    private let channel: Channel
    public let title: Title
    public let license: License
    public let payable: Payable
    public let receipt: Receipt
    
    /// Initializes the Trail struct with a given channel.
    ///
    /// - Parameter channel: The communication channel
    public init(channel: Channel) {
        self.channel = channel
        self.title = Title(channel: channel)
        self.license = License(channel: channel)
        self.payable = Payable(channel: channel)
        self.receipt = Receipt(channel: channel)
    }
    
    /// Returns a Boolean value indicating whether the Trail has been initialized.
    ///
    /// - Parameter completion: An optional closure to be called upon completion with the initialization status.
    /// - Throws: An error if the initialization check fails.
    /// - Returns: `true` if initialized, `false` otherwise.
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
    
    /// Retrieves the blockchain address associated with the Trail.
    ///
    /// - Parameter completion: An optional closure to be called upon completion with the blockchain address.
    /// - Throws: An error if the address retrieval fails.
    /// - Returns: The blockchain address as a string.
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
    
    /// Retrieves the ID associated with the Trail.
    ///
    /// - Parameter completion: An optional closure to be called upon completion with the Trail's ID.
    /// - Throws: An error if the ID retrieval fails.
    /// - Returns: The Trail's ID as an optional string.
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
    
    /// Guards the Trail with specified parameters.
    ///
    /// - Parameters:
    ///   - ptr: The pointer for the Trail.
    ///   - usecases: An array of usecases.
    ///   - destinations: An optional array of destination addresses.
    ///   - onPass: An optional closure to be called when the guard operation succeeds.
    ///   - onFail: An optional closure to be called when the guard operation fails.
    ///   - origin: An optional origin parameter.
    /// - Throws: An error if the guard operation fails.
    /// - Returns: `true` if the guard operation succeeds, `false` otherwise.
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
