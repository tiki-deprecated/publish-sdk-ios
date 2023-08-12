/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation

/// License use.
///
/// LicenseUse defines explicit uses for an asset, which are extremely helpful in programmatic search and enforcement of your
/// LicenseRecords.
///
/// Usecases explicitly define HOW an asset may be used. You can either use a list of common enumerations or define your own using
/// LicenseUsecase.
///
/// Destinations explicitly define WHO can use an asset. Destinations can be a wildcard URL (*.your-co.com), a string defining a category of
/// companies, or more. You can use ECMAScript Regex to specify flexible and easily enforceable rules.
public struct LicenseUse: Codable {
    /// Usecases explicitly define HOW an asset may be used.
    let usecases: [LicenseUsecase]
    
    /// Destinations explicitly define WHO can use an asset.
    let destinations: [String]?
    
    /// Create a new `LicenseUse` instance.
    ///
    /// - Parameters:
    ///   - usecases: Usecases explicitly define HOW an asset may be used.
    ///   - destinations: Destinations explicitly define WHO can use an asset.
    public init(usecases: [LicenseUsecase], destinations: [String]? = nil) {
        self.usecases = usecases
        self.destinations = destinations
    }
}
