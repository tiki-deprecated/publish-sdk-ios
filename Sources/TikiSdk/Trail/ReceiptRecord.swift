/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct ReceiptRecord {
    public let id: String
    public let payable: PayableRecord
    public let amount: String
    public let description: String?
    public let reference: String?
    
    public init?(from: RspReceipt){
        guard let payableRecord = PayableRecord(from: from.payable!), from.id != nil, from.amount != nil else{
            return nil
        }
        self.id = from.id!
        self.payable = payableRecord
        self.amount = from.amount!
        self.description = from.description
        self.reference = from.reference
        
    }
}
