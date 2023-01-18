/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct RequestLog{
    var icon: String
    var message: String
    var _timestamp: Date = Date()
    var timestamp: String{
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter.string(from: _timestamp)
        }
    }
}
