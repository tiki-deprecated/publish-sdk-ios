/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspToken: Rsp {
    let accessToken: String?
    let tokenType: String?
    let expires: Date?
    let refreshToken: String?
    let scope: [String]?
    var requestId: String?
    
    init(from: [String : Any?]) {
        self.accessToken = from["accessToken"] as? String
        self.tokenType = from["tokenType"] as? String
        self.expires = from["expires"] as? Int64 != nil ? Date(milliseconds: from["expiry"] as! Int64) : nil
        self.refreshToken = from["refreshToken"] as? String
        self.scope = from["scope"] as? [String]
        self.requestId = from["requestId"] as? String
        
    }
}
