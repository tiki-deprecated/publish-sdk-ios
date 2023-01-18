/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import TikiSdk

class TikiSdkExampleAppModel: ObservableObject{
    
    @Published var wallets: [String:TikiSdk] = [:]
    @Published var walletList: [String] = []
    @Published var ownershipDictionary: [String: TikiSdkOwnership] = [:]
    @Published var consentDictionary: [String: TikiSdkConsent] = [:]
    @Published var stream: Stream = Stream(source: UUID().uuidString)
    
    @Published var selectedWalletAddress : String = ""
    @Published var isConsentGiven = false
    
    var tikiSdk: TikiSdk? {
        get{
            if(!wallets.isEmpty){
                return wallets[selectedWalletAddress]
            }
            return nil
        }
    }
    
    var ownership: TikiSdkOwnership? {
        get {
            if(!ownershipDictionary.isEmpty){
                return ownershipDictionary[tikiSdk!.address!]
            }
            return nil
        }
    }
    
    var consent: TikiSdkConsent? {
        get {
            if(!consentDictionary.isEmpty){
                return consentDictionary[ownership!.transactionId]
            }
            return nil
        }
    }
}
