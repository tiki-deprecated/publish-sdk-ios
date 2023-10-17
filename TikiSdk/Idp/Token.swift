/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct Token{
    public let accessToken: String
    public let tokenType: String
    public let expires: Date?
    public let refreshToken: String?
    public let scope: [String]?
    
    public init(from: RspToken){
        self.accessToken = from.accessToken!
        self.tokenType = from.tokenType!
        self.expires = from.expires
        self.refreshToken = from.refreshToken
        self.scope = from.scope
    }
}
