//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct PayableRecord{
    let id: String
    let license: LicenseRecord
    let amount: String
    let type: String?
    let description: String?
    let expiry: Date?
    let reference: String?
}
