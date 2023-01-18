/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import TikiSdk

class TikiSdkExampleAppModel: ObservableObject{
    
    @Published var walletList: [TikiSdk] = []
    @Published var ownershipDictionary: [String: [TikiSdkOwnership]] = [:]
    @Published var consentDictionary: [String: TikiSdkConsent] = [:]
    @Published var stream: Stream = Stream(source: UUID().uuidString)
    
    @Published var selectedWalletIndex = 0
    @Published var selectedOwnershipIndex = 0
    @Published var selectedStreamIndex = 0
    @Published var isConsentGiven = false
    
    var tikiSdk: TikiSdk? {
        get{
            if(!walletList.isEmpty){
                return walletList[selectedWalletIndex]
            }
            return nil
        }
    }
    
    var ownershipList: [TikiSdkOwnership] {
        get{
            if(tikiSdk != nil && ownershipDictionary[tikiSdk!.address!] != nil){
                return ownershipDictionary[tikiSdk!.address!]!
            }
            return []
        }
    }
    
    var ownership: TikiSdkOwnership? {
        get {
            if(!ownershipList.isEmpty){
                return ownershipList[selectedOwnershipIndex]
            }
            return nil
        }
    }
    
    var consent: TikiSdkConsent? {
        get {
            if(!consentDictionary.isEmpty){
                return consentDictionary[ownershipList[selectedOwnershipIndex].transactionId]
            }
            return nil
        }
    }
}
