//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct RspToken: Rsp, Codable {
    let accessToken: String?
    let tokenType: String?
    let expires: Date?
    let refreshToken: String?
    let scope: [String]?
    let requestId: String?
}
