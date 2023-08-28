/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct PayableRecord{
    let id: String
    let license: LicenseRecord
    let amount: String
    let type: String?
    let description: String?
    let expiry: Date?
    let reference: String?
    
    init?(from: RspPayable){
        guard let licenseRecord = LicenseRecord(from: from.license!), from.id != nil, from.license != nil, from.amount != nil else{
            return nil
        }
        id = from.id!
        license = licenseRecord
        amount = from.amount!
        type = from.type
        description = from.description
        expiry = from.expiry
        reference = from.reference
    }
}
