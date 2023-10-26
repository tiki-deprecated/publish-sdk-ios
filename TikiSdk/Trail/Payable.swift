/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// This class represents a payable reference with his methods
public class Payable {
    private let channel: Channel
    
    /// Initializes the Trail struct with a given channel.
    ///
    /// - Parameter channel: The communication channel
    public init(channel: Channel) {
        self.channel = channel
    }
    
    
    /// Creates a new payable reference with the specified parameters and communicates with the server to record the payment.
    ///
    /// Use this function to initiate a payment transaction, providing details such as the associated license, payment amount, payment type, and optional information. The operation is asynchronous, and errors may be thrown during its execution.
    /// - Parameters:
    ///   - licenseId: The identifier of the associated license.
    ///   - amount: The payment amount as a string.
    ///   - type: The type of payment (e.g., "Credit Card")
    ///   - expiry: Optional payment expiration date.
    ///   - description: Optional payment description.
    ///   - reference: Optional reference information.
    ///   - completion: A closure to be executed upon completion, providing a PayableRecord or nil.
    /// - Throws: An error if the payment creation process encounters an issue.
    /// - Returns: A PayableRecord object if the payment creation was successful, or nil otherwise.
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
    /// Retrieves a payable reference by its unique identifier and communicates with the server to fetch the corresponding payment information.
    ///
    ///Use this function to get detailed information about a specific payment reference by providing its identifier. The operation is asynchronous, and errors may be thrown during its execution.
    ///
    ///  - Parameters:
    ///   - id: The unique identifier of the payable reference to retrieve.
    ///   - completion: A closure to be executed upon completion, providing a PayableRecord or nil.
    /// - Throws: An error if the retrieval process encounters an issue.
    /// - Returns:A PayableRecord object if the retrieval was successful, or nil otherwise.
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
    
     /// Retrieves a list of all payable references associated with a specific license and communicates with the server to fetch the payment information for each reference.
     ///
     /// Use this function to obtain a collection of payment references linked to a particular license. The operation is asynchronous, and errors may be thrown during its execution.
    ///  - Parameters:
    ///   - licensId:  The identifier of the license for which you want to retrieve payable references.
    ///   - completion: : A closure to be executed upon completion, providing an array of PayableRecords.
    /// - Throws: An error if the retrieval process encounters an issue.
    /// - Returns:An array of PayableRecord objects representing the payable references.
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
