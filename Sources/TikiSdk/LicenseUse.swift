import Foundation

/// License use
///
/// Define explicit uses for an asset. LicenseUses are extremely helpful in programmatic search
/// and enforcement of your LicenseRecords.
///
/// usecases explicitly define HOW an asset may be used. Use either our list of common enumerations
/// or define your own using LicenseUsecase.
///
/// destinations define WHO can use an asset. destinations narrow down usecases to a set of URLs,
/// categories of companies, or more. Use ECMAScript Regex to specify flexible and easily enforceable
/// rules.
public struct LicenseUse: Codable {
    /// Usecases explicitly define HOW an asset may be used.
    let usecases: [LicenseUsecase]
    
    /// Destinations explicitly define WHERE an asset may be used.
    /// Destinations can be: a wildcard URL (*.your-co.com),
    /// a string defining a category of
    let destinations: [String]?
    
    /// Create an empty LicenseUse.
    ///
    /// - Parameters:
    ///   - usecases: Usecases explicitly define HOW an asset may be used.
    ///   - destinations: Destinations explicitly define WHERE an asset may be used.
    public init(usecases: [LicenseUsecase], destinations: [String]? = nil) {
        self.usecases = usecases
        self.destinations = destinations
    }
}
