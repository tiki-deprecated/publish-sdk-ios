/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation

/// An enumeration of default accepted use cases for a `LicenseUsecase`.
public enum LicenseUsecaseEnum: String, Codable, CaseIterable {
    
    /// Use case for attribution.
    case attribution = "attribution"
    
    /// Use case for retargeting.
    case retargeting = "retargeting"
    
    /// Use case for personalization.
    case personalization = "personalization"
    
    /// Use case for AI training.
    case aiTraining = "ai_training"
    
    /// Use case for distribution.
    case distribution = "distribution"
    
    /// Use case for analytics.
    case analytics = "analytics"
    
    /// Use case for support.
    case support = "support"
    
    /// Returns the string value for the enum.
    var value: String {
        return self.rawValue
    }
    
    /// Returns a `LicenseUsecaseEnum` instance for the given string value.
    /// - Parameters:
    ///    - value: A string value representing a use case for a license.
    /// - Throws: An `NSError` object with domain `InvalidLicenseUsecaseErrorDomain` and code 0, if `value`
    /// is not a valid `LicenseUsecaseEnum` value.
    /// - Returns: A `LicenseUsecaseEnum` instance that matches the given string value.
    static func fromValue(_ value: String) throws -> LicenseUsecaseEnum {
        for type in LicenseUsecaseEnum.allCases {
            if type.rawValue == value {
                return type
            }
        }
        throw NSError(domain: "InvalidLicenseUsecaseErrorDomain", code: 0, userInfo: ["value": value])
    }
}
