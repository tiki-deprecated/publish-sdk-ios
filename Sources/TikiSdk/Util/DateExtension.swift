//
//  File.swift
//  
//
//  Created by Ricardo on 27/08/23.
//

import Foundation

extension Date{
    func millisecondsSinceEpoch() -> Int64{
        return Int64(round(self.timeIntervalSince1970 * 1000))
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
