/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The Consent NFT data structure.
///
/// It registers the consent from the creator of
/// an Ownership NFT for the use of that data in a specific *destination*.
///
/// Optionally the Consent can describe *about* its usage, a *reward* that will
/// be given in exchange and an *expiry* date and time for the consent.
public struct TikiSdkConsent : Codable{
    /// Transaction ID corresponding to the ownership mint for the data source.
    public var ownershipId: String

    /// The identifier of the paths and use cases for this consent.
    public var destination: TikiSdkDestination

    /// Optional description of the consent.
    public var about: String?

    /// Optional reward description the user will receive for this consent.
    public var reward: String?

    /// The transaction id of this registry.
    public var transactionId: String
    
    /// The Consent expiration. *nil* for no expiration.
    public var expiry: Date?
}
