import Foundation

public class TikiSdkConsent : Codable{
    /// Transaction ID corresponding to the ownership mint for the data source.
    public var ownershipId: String

    /// The identifier of the paths and use cases for this consent.
    public var destination: TikiSdkDestination

    /// Optional description of the consent.
    public var about: String

    /// Optional reward description the user will receive for this consent.
    public var reward: String

    /// The transaction id of this registry.
    public var transactionId: String
    
    /// The Consent expiration in miliseconds since Epoch. nil for no expiration.
    public var expiry: Int?

    /// Builds *TikiSdkConsent* from *jsonString*
    ///
    /// - Parameters
    ///     - jsonString: valid json representation of *TikiSdkConsent*
    ///
    /// - Returns: *TikiSdkConsent*
    public static func fromJson(jsonString : String) -> TikiSdkConsent? {
        let decoder = JSONDecoder()
        do {
            let tikiSdkConsent = try decoder.decode(TikiSdkConsent.self, from:  Data(jsonString.utf8))
            return tikiSdkConsent
        } catch {
            print(error)
            return nil
        }
    }
    
    /// Converts this to a JSON String
    ///
    /// - Returns: valid json representation of *TikiSdkConsent*
    public func toJson() -> String{
        let encoder = JSONEncoder()
        do {
            return String(data: try encoder.encode(self), encoding: String.Encoding.utf8)!;
        } catch {
            objc_exception_rethrow()
        }
    }
}
