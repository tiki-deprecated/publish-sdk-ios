/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

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
        completion: @escaping (ReceiptRecord?) -> Void
    ) async throws -> ReceiptRecord? {
        let receiptReq = ReqReceipt(payableId: payableId, amount: amount, description: description, reference: reference)
        let rspReceipt: RspReceipt = try await channel.request(
            method: TrailMethod.RECEIPT_CREATE,
            request: receiptReq) { rsp in
                let paybaleResp = RspReceipt(from: rsp)
                return paybaleResp
            }
        let receipt = ReceiptRecord(from: rspReceipt)
        completion(receipt)
        return receipt
    }
    
    func get(id: String, completion: @escaping (ReceiptRecord?) -> Void) async throws -> ReceiptRecord? {
        let receiptReq = ReqReceiptGet(id: id)
        let rspReceipt: RspReceipt = try await channel.request(
            method: TrailMethod.RECEIPT_GET,
            request: receiptReq) { rsp in
                let paybaleResp = RspReceipt(from: rsp)
                return paybaleResp
            }
        let receipt = ReceiptRecord(from: rspReceipt)
        completion(receipt)
        return receipt
    }
    
    func all(payableId: String, completion: @escaping ([ReceiptRecord]) -> Void) async throws -> [ReceiptRecord] {
        let receiptReq = ReqReceiptAll(payableId: payableId)
        let rspReceipts: RspReceipts = try await channel.request(
            method: TrailMethod.RECEIPT_ALL,
            request: receiptReq) { rsp in
                let receiptsResp = RspReceipts(from: rsp)
                return receiptsResp
            }
        let receiptAll: [ReceiptRecord] = rspReceipts.receipts == nil ? [] :
        (rspReceipts.receipts! as [RspReceipt]).map{ ReceiptRecord(from: $0)! }
        completion(receiptAll)
        return receiptAll
    }
}
