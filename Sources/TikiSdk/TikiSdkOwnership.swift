import Foundation

public class TikiSdkOwnership : Codable{
    
    /// The identification of the source.
    public var source : String

    /// The type of the data source: data point, pool or stream.
    public var type : TikiSdkDataType

     /// The origin from which the data was generated.
    public var origin : String

     /// The transaction id of this registry.
    public var transactionId : String

     /// The description about the data.
    public var about : String

     /// The kinds of data this contains.
    public var contains : [String]

    /// Builds *TikiSdkOwnership* from *jsonString*
    ///
    /// - Parameters
    ///     - jsonString: valid json representation of *TikiSdkConsent*
    ///
    /// - Returns: *TikiSdkOwnership*
    public static func fromJson(jsonString : String) -> TikiSdkOwnership{
        let decoder = JSONDecoder()
        do {
            let tikiSdkOwnership = try decoder.decode(TikiSdkOwnership.self, from:  Data(jsonString.utf8))
            return tikiSdkOwnership
        } catch {
            objc_exception_rethrow()
        }
    }
    
    /// Converts this to a JSON String
    ///
    /// - Returns: valid json representation of *TikiSdkOwnership*
    public func toJson() -> String{
        let encoder = JSONEncoder()
        do {
            return String(data: try encoder.encode(self), encoding: String.Encoding.utf8)!;
        } catch {
            objc_exception_rethrow()
        }
    }
    
}
