/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The `Receipt` class handles interactions related to receipts on the blockchain.
public class Receipt {
    private let channel: Channel
    
    
    /// Initializes the Receipt class with a given communication channel.
    ///
    /// - Parameter channel: The communication channel to the blockchain.
    init(channel: Channel) {
        self.channel = channel
    }
    
    /// Creates a receipt with specified parameters.
    ///
    /// - Parameters:
    ///   - payableId: The ID of the payable associated with the receipt.
    ///   - amount: The amount of the receipt.
    ///   - description: An optional description for the receipt.
    ///   - reference: An optional reference for the receipt.
    ///   - completion: An optional closure to be called upon completion with the receipt record.
    /// - Throws: An error if receipt creation fails.
    /// - Returns: The created `ReceiptRecord` if successful, or `nil` if there is an error.
    public func create(
        payableId: String,
        amount: String,
        description: String? = nil,
        reference: String? = nil,
        completion: ((ReceiptRecord?) -> Void)? = nil
    ) async throws -> ReceiptRecord? {
        let receiptReq = ReqReceipt(payableId: payableId, amount: amount, description: description, reference: reference)
        let rspReceipt: RspReceipt = try await channel.request(
            method: TrailMethod.RECEIPT_CREATE,
            request: receiptReq) { rsp in
                let paybaleResp = RspReceipt(from: rsp)
                return paybaleResp
            }
        let receipt = ReceiptRecord(from: rspReceipt)
        completion?(receipt)
        return receipt
    }
    
    /// Retrieves a receipt by its ID.
    ///
    /// - Parameters:
    ///   - id: The ID of the receipt to retrieve.
    ///   - completion: An optional closure to be called upon completion with the receipt record.
    /// - Throws: An error if receipt retrieval fails.
    /// - Returns: The retrieved `ReceiptRecord` if successful, or `nil` if there is an error.
    public func get(id: String, completion: ((ReceiptRecord?) -> Void)? = nil) async throws -> ReceiptRecord? {
        let receiptReq = ReqReceiptGet(id: id)
        let rspReceipt: RspReceipt = try await channel.request(
            method: TrailMethod.RECEIPT_GET,
            request: receiptReq) { rsp in
                let paybaleResp = RspReceipt(from: rsp)
                return paybaleResp
            }
        let receipt = ReceiptRecord(from: rspReceipt)
        completion?(receipt)
        return receipt
    }
    
    /// Retrieves all receipts associated with a payable.
    ///
    /// - Parameters:
    ///   - payableId: The ID of the payable to retrieve receipts for.
    ///   - completion: An optional closure to be called upon completion with an array of receipt records.
    /// - Throws: An error if receipt retrieval fails.
    /// - Returns: An array of `ReceiptRecord` objects associated with the payable.
    public func all(payableId: String, completion: (([ReceiptRecord]) -> Void)? = nil) async throws -> [ReceiptRecord] {
        let receiptReq = ReqReceiptAll(payableId: payableId)
        let rspReceipts: RspReceipts = try await channel.request(
            method: TrailMethod.RECEIPT_ALL,
            request: receiptReq) { rsp in
                let receiptsResp = RspReceipts(from: rsp)
                return receiptsResp
            }
        let receiptAll: [ReceiptRecord] = rspReceipts.receipts == nil ? [] :
        (rspReceipts.receipts! as [RspReceipt]).map{ ReceiptRecord(from: $0)! }
        completion?(receiptAll)
        return receiptAll
    }
}
