/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct Token{
    let accessToken: String
    let tokenType: String
    let expires: Date?
    let refreshToken: String?
    let scope: [String]?
    
    init(from: RspToken){
        self.accessToken = from.accessToken!
        self.tokenType = from.tokenType!
        self.expires = from.expires
        self.refreshToken = from.refreshToken
        self.scope = from.scope
    }
}
