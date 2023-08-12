//
//  File.swift
//  
//
//  Created by Ricardo on 12/08/23.
//

import Foundation

struct RspVerify: Rsp{
    let isVerified: Bool
    var requestId: String?
}
