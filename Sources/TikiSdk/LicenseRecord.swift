import Foundation

/// License Records describe the terms around which a data asset may be used and MUST
/// contain a reference to the corresponding Title Record.
/// [Learn more](https://docs.mytiki.com/docs/offer-customization)  about License Records.
public struct LicenseRecord: Codable {
    /// This record's id
    var id: String?
    /// The [TitleRecord] for this license
    var title: TitleRecord
    /// A list describing how an asset can be used
    var uses: [LicenseUse]
    /// The legal terms for the license
    var terms: String
    /// A human-readable description of the license
    var description: String?
    /// The date when the license expires
    var expiry: Date?
}
