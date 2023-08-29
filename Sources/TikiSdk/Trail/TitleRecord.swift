/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// A record describing a data asset, which contains a `PointerRecord` to your system.
/// Title Records are used to provide metadata about a data asset that TIKI clients can use to evaluate the value of the asset
/// for their use cases. A Title Record must contain a `PointerRecord` that identifies the asset in your system.
///
/// Learn more about Title Records in [TIKI's documentation](https://docs.mytiki.com/docs/offer-customization).
public struct TitleRecord {
    
    /// This record's unique identifier.
    public let id: String
    
    /// A hashed `PointerRecord` identifying the asset in your system.
    public let hashedPtr: String
    
    /// A list of tags that describe the asset in a search-friendly way.
    public let tags: [Tag]
    
    /// A human-readable description of the asset.
    public let description: String?
    
    /// An optional field to override the default origin from which the data was generated.
    public let origin: String?
    
    /// Initializes a new instance of `TitleRecord`.
     
    /// - Parameters:
    ///     - id: This record's unique identifier.
    ///     - hashedPtr: A hashed `PointerRecord` identifying the asset in your system.
    ///     - tags: A list of tags that describe the asset in a search-friendly way.
    ///     - description: A human-readable description of the asset.
    ///     - origin: An optional field to override the default origin from which the data was generated
    public init(id: String, hashedPtr: String, tags: [Tag], description: String?, origin: String?) {
        self.id = id
        self.hashedPtr = hashedPtr
        self.tags = tags
        self.description = description
        self.origin = origin
    }
    
    public init?(from: RspTitle){
        guard from.id != nil, from.hashedPtr != nil, from.tags != nil else {
            return nil
        }
        self.id = from.id!
        self.hashedPtr = from.hashedPtr!
        self.tags = from.tags!
        self.description = from.description
        self.origin = from.origin
    }
}

