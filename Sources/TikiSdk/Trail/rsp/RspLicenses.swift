/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspLicenses: Rsp {
    let licenses: [RspLicense]?
    let requestId: String
    
    init(from: [String : Any?]) {
        self.licenses = (from["licenses"] as? [[String: Any?]])?.map{ license in RspLicense(from: license) }
        self.requestId = from["requestId"] as! String
    }
}

