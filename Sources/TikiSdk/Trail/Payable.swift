//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

class Payable {
    private let channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
    }
    
    func create(
        licenseId: String,
        amount: String,
        type: String,
        expiry: Date? = nil,
        description: String? = nil,
        reference: String? = nil,
        completion: @escaping (Result<PayableRecord, Error>) -> Void
    ) {
        channel.request(
            TrailMethod.PAYABLE_CREATE,
            ReqPayable(licenseId: licenseId, amount: amount, type: type, expiry: expiry, description: description, reference: reference)
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspPayable = try RspPayable.from(args)
                    let payableRecord = try PayableRecord.from(rsp)
                    completion(.success(payableRecord))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func get(id: String, completion: @escaping (Result<PayableRecord, Error>) -> Void) {
        channel.request(
            TrailMethod.PAYABLE_GET,
            ReqPayableGet(id: id)
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspPayable = try RspPayable.from(args)
                    let payableRecord = try PayableRecord.from(rsp)
                    completion(.success(payableRecord))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func all(licenseId: String, completion: @escaping (Result<[PayableRecord], Error>) -> Void) {
        channel.request(
            TrailMethod.PAYABLE_ALL,
            ReqPayableAll(licenseId: licenseId)
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspPayables = try RspPayables.from(args)
                    let payables = rsp.payables?.compactMap { payable in
                        try? PayableRecord.from(payable)
                    } ?? []
                    completion(.success(payables))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
