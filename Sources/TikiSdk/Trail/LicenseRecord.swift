/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// A `LicenseRecord` describes the terms under which a data asset may be used and MUST contain a reference to the
/// corresponding `TitleRecord`.
///
/// Learn more about `LicenseRecords` at https://docs.mytiki.com/docs/offer-customization.
public struct LicenseRecord {
    
    /// This record's unique identifier.
    var id: String?
    
    /// The `TitleRecord` associated with this license.
    var title: TitleRecord
    
    /// A list of `Use` instances describing how an asset can be used.
    var uses: [Use]
    
    /// The legal terms for the license.
    var terms: String
    
    /// A human-readable description of the license.
    var description: String?
    
    /// The date when the license expires.
    var expiry: Date?
    
    init?(from: RspLicense){
        guard let titleRecord = TitleRecord(from: from.title!), from.id != nil, from.title != nil, from.uses != nil, from.terms != nil, from.title != nil else{
            return nil
        }
        self.id = from.id
        self.title = titleRecord
        self.uses = from.uses!
        self.terms = from.terms!
        self.description = from.description
        self.expiry = from.expiry
    }
}

