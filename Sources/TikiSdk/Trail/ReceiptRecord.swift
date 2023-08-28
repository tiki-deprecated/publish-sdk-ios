/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReceiptRecord {
    let id: String
    let payable: PayableRecord
    let amount: String
    let description: String?
    let reference: String?
    
    init?(from: RspReceipt){
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
