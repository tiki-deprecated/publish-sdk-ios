/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// License use.
///
/// Use defines explicit uses for an asset, which are extremely helpful in programmatic search and enforcement of your
/// LicenseRecords.
///
/// Usecases explicitly define HOW an asset may be used. You can either use a list of common enumerations or define your own using
/// Usecase.
///
/// Destinations explicitly define WHO can use an asset. Destinations can be a wildcard URL (*.your-co.com), a string defining a category of
/// companies, or more. You can use ECMAScript Regex to specify flexible and easily enforceable rules.
public struct Use: Codable {
    /// Usecases explicitly define HOW an asset may be used.
    public let usecases: [Usecase]
    
    /// Destinations explicitly define WHO can use an asset.
    public let destinations: [String]?
    
    /// Create a new `Use` instance.
    ///
    /// - Parameters:
    ///   - usecases: Usecases explicitly define HOW an asset may be used.
    ///   - destinations: Destinations explicitly define WHO can use an asset.
    public init(usecases: [Usecase], destinations: [String]? = nil) {
        self.usecases = usecases
        self.destinations = destinations
    }
    
    public init(from: [String: Any]){
        self.usecases = (from["usecases"] as? [String])?.map{ usecase in Usecase.from(usecase: usecase) } ?? []
        self.destinations = from["destinations"] as? [String] ?? []
    }
    
    public func asDictionary() -> [String: [String]?] {
        return [
            "usecases": usecases.map{ usecase in usecase.value },
            "destinations": destinations
        ]
    }
}
