/*
 Copyright (c) TIKI Inc.
 MIT license. See LICENSE file in root directory.
*/

/**
  Title record
  
  Title Records describe a data asset and MUST contain a Pointer Record to
  your system. [Learn more](https://docs.mytiki.com/docs/offer-customization)
  about Title Records.
  
  - Parameters:
     - id: This record's id.
     - ptr: A Pointer Record identifying the asset.
     - tags: A list of search-friendly tags describing the asset.
     - description: A human-readable description of the asset.
     - origin: Overrides the default origin from which the data was generated.
  */
public struct TitleRecord: Codable {
     let id: String
     let hashedPtr: String
     let tags: [TitleTag]
     let description: String?
     let origin: String?
 }
