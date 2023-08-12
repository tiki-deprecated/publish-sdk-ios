//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct Token: Decodable{
    let accessToken: String
    let tokenType: String
    let expires: Date?
    let refreshToken: String?
    let scope: [String]?
}
