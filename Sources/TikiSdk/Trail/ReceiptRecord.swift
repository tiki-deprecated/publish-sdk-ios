//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct ReceiptRecord {
    let id: String
    let payable: PayableRecord
    let amount: String
    let description: String?
    let reference: String?
}
