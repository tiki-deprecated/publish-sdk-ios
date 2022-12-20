import Foundation

public class TikiSdkConsent : Codable{
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
    
    /// The Consent expiration in miliseconds since Epoch. nil for no expiration.
    public var expiry: Int?
}
