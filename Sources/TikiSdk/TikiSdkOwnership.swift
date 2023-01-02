import Foundation

/// The Ownership NFT.
///
/// The registry of ownership to a given data point, pool, or stream.
public struct TikiSdkOwnership : Codable{
    
    /// The identification of the source.
    public var source : String

    /// The type of the data source: data point, pool or stream.
    public var type : TikiSdkDataTypeEnum

     /// The origin from which the data was generated.
    public var origin : String

     /// The transaction id of this registry.
    public var transactionId : String

     /// The description about the data.
    public var about : String?

     /// The kinds of data this contains.
    public var contains : [String]
    
}
