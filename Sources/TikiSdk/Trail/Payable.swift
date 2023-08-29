/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public class Payable {
    private let channel: Channel
    
    public init(channel: Channel) {
        self.channel = channel
    }
    
    public func create(
        licenseId: String,
        amount: String,
        type: String,
        expiry: Date? = nil,
        description: String? = nil,
        reference: String? = nil,
        completion: ((PayableRecord?) -> Void)? = nil
    ) async throws -> PayableRecord? {
        let paybaleReq = ReqPayable(
            licenseId: licenseId,
            amount: amount,
            type: type,
            expiry: expiry,
            description: description,
            reference: reference
        )
        let rspPayable: RspPayable = try await channel.request(
            method: TrailMethod.PAYABLE_CREATE,
            request: paybaleReq) { rsp in
                let paybaleResp = RspPayable(from: rsp)
                return paybaleResp
            }
        let payable = PayableRecord(from: rspPayable)
        completion?(payable)
        return payable
    }
    
    public func get(id: String, completion: ((PayableRecord?) -> Void)? = nil) async throws -> PayableRecord? {
             let paybaleReq = ReqPayableGet(id: id)
             let rspPayable: RspPayable = try await channel.request(
                 method: TrailMethod.PAYABLE_GET,
                 request: paybaleReq) { rsp in
                     let paybaleResp = RspPayable(from: rsp)
                     return paybaleResp
                 }
             let payable = PayableRecord(from: rspPayable)
             completion?(payable)
             return payable
         }
    
    public func all(licenseId: String, completion: (([PayableRecord]) -> Void)? = nil) async throws -> [PayableRecord] {
        let paybaleReq = ReqPayableAll(licenseId: licenseId)
        let rspPayables: RspPayables = try await channel.request(
            method: TrailMethod.PAYABLE_ALL,
            request: paybaleReq) { rsp in
                let payablesResp = RspPayables(from: rsp)
                return payablesResp
            }
        let payableAll: [PayableRecord] = rspPayables.payables == nil ? [] :
            (rspPayables.payables! as [RspPayable]).map{ PayableRecord(from: $0)! }
        completion?(payableAll)
        return payableAll
    }
}
