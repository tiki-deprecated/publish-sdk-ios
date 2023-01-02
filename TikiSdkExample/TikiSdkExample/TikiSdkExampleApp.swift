//
//  TikiSdkExampleApp.swift
//  TikiSdkExample
//
//  Created by Ricardo on 30/12/22.
//

import SwiftUI

@main
struct TikiSdkExampleApp: App {
    
    let tikiSdkService: TikiSdkExampleService = TikiSdkExampleService()
    
    var body: some Scene {
        WindowGroup {
            AddressView(tikiSdkService)
        }
    }
}
