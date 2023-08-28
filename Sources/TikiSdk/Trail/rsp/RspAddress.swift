/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspAdress: Rsp {
    let address: String
    var requestId: String?
    
    init(from: [String : Any?]) {
        self.address = from["address"] as! String
        self.requestId = from["requestId"] as? String
    }
}
