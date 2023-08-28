/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RspInitialize: Rsp {
    let id: String?
    let address: String?
    var requestId: String?
    
    init(from: [String : Any?]) {
        self.id = from["id"] as? String
        self.address = from["address"] as? String
        self.requestId = from["requestId"] as? String
    }

}
