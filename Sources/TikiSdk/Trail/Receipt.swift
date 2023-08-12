//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

class Receipt {
    private let channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
    }
    
    func create(
        payableId: String,
        amount: String,
        description: String? = nil,
        reference: String? = nil,
        completion: @escaping (Result<ReceiptRecord, Error>) -> Void
    ) {
        channel.request(
            TrailMethod.RECEIPT_CREATE,
            ReqReceipt(payableId: payableId, amount: amount, description: description, reference: reference)
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspReceipt = try RspReceipt.from(args)
                    let receiptRecord = try ReceiptRecord.from(rsp)
                    completion(.success(receiptRecord))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func get(id: String, completion: @escaping (Result<ReceiptRecord, Error>) -> Void) {
        channel.request(
            TrailMethod.RECEIPT_GET,
            ReqReceiptGet(id: id)
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspReceipt = try RspReceipt.from(args)
                    let receiptRecord = try ReceiptRecord.from(rsp)
                    completion(.success(receiptRecord))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func all(payableId: String, completion: @escaping (Result<[ReceiptRecord], Error>) -> Void) {
        channel.request(
            TrailMethod.RECEIPT_ALL,
            ReqReceiptAll(payableId: payableId)
        ) { args in
            withCheckedContinuation { continuation in
                do {
                    let rsp: RspReceipts = try RspReceipts.from(args)
                    let receipts = rsp.receipts?.compactMap { receipt in
                        try? ReceiptRecord.from(receipt)
                    } ?? []
                    completion(.success(receipts))
                    continuation.resume(returning: ())
                } catch {
                    completion(.failure(error))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
