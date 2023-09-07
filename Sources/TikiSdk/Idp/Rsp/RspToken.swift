/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public struct RspToken: Rsp {
    public let accessToken: String?
    public let tokenType: String?
    public let expires: Date?
    public let refreshToken: String?
    public let scope: [String]?
    public let requestId: String
    
    public init(from: [String : Any?]) {
        self.accessToken = from["accessToken"] as? String
        self.tokenType = from["tokenType"] as? String
        self.expires = from["expires"] as? Int64 != nil ? Date(milliseconds: from["expiry"] as! Int64) : nil
        self.refreshToken = from["refreshToken"] as? String
        self.scope = from["scope"] as? [String]
        self.requestId = from["requestId"] as! String
        
    }
}
