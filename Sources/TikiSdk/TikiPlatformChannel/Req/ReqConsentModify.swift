/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The request for the `modifyConsent`method call in the Platform Channel.
struct ReqConsentModify: Req {
    let requestId, ownershipId: String
    let destination: TikiSdkDestination
    let about, reward: String?
    let expiry: Int?
    
    init(requestId: String, ownershipId: String, destination: TikiSdkDestination, about: String? = nil, reward: String? = nil, expiry: Date? = nil){
        var sinceEpoch : Int? = nil
        let expiration = expiry?.timeIntervalSince1970
        if(expiration != nil){
            sinceEpoch = Int(expiration!) * 1000
        }
        self.requestId = requestId
        self.ownershipId = ownershipId
        self.destination = destination
        self.about = about
        self.reward = reward
        self.expiry = sinceEpoch
    }
    
    /// Converts this to a JSON String
    ///
    /// - Returns: valid json representation
    public func toJson() -> String{
        let encoder = JSONEncoder()
        do {
            return String(data: try encoder.encode(self), encoding: String.Encoding.utf8)!;
        } catch {
            objc_exception_rethrow()
        }
    }
}
