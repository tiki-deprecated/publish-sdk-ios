//
//  TikiSdkExampleService.swift
//  TikiSdkExample
//
//  Created by Ricardo on 30/12/22.
//

import Foundation
import TikiSdk

public class TikiSdkExampleService{
    let origin = "com.mytiki.tiki_sdk_example"
    let apiId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90"
    
    func initTikiSdk(address: String? = nil) async throws -> TikiSdk{
        return try await TikiSdk(origin: origin, apiId: apiId, address: address)
    }
}
