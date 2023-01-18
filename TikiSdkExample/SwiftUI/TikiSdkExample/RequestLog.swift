//
//  RequestLog.swift
//  TikiSdkExample
//
//  Created by Ricardo on 18/01/23.
//

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
