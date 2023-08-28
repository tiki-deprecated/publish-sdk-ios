/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspLicenses: Rsp {
    let licenses: [RspLicense]?
    let requestId: String
    
    init(from: [String : Any?]) {
        self.licenses = (from["licenses"] as? [[String: Any?]])?.map{ RspLicense(from: $0) }
        self.requestId = from["requestId"] as! String
    }
}

