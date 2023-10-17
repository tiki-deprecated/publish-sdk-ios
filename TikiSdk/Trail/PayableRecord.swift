/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct PayableRecord{
    public let id: String
    public let license: LicenseRecord
    public let amount: String
    public let type: String?
    public let description: String?
    public let expiry: Date?
    public let reference: String?
    
    public init?(from: RspPayable){
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
