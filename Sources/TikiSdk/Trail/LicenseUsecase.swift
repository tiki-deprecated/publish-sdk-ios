/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation

/// A use case for a license, describing how an asset may be used.
/// Use cases explicitly define how an asset may be used. Use either our list of common enumerations or define your
/// own using `LicenseUsecaseEnum`. Custom use cases can be created by using a value that does not match any of the predefined cases.
///
/// - Parameter value: The string value of the use case. If the value matches a predefined enumeration case, that case will be used;
/// otherwise, a custom use case will be created with the given value.
public class LicenseUsecase: Codable {
    
    private var _value: String
    
    /// The string value of the use case.
    public var value: String {
        return _value
    }
    
    /// Creates a new `LicenseUsecase` with the given value.
    ///
    /// - Parameter value: The string value of the use case. If the value matches a
    /// predefined enumeration case, that case will be used; otherwise, a custom use case will be created with the given value.
    public init(_ value: String) {
        do {
            let licenseUsecaseEnum = try LicenseUsecaseEnum.fromValue(value)
            _value = licenseUsecaseEnum.rawValue
        } catch {
            _value = "custom:\(value)"
        }
    }
    
    /// Creates a new `LicenseUsecase` with the given `LicenseUsecaseEnum` value.
    ///
    /// - Parameter licenseUsecaseEnum: The enumeration value of the use case.
    public init(_ licenseUsecaseEnum: LicenseUsecaseEnum) {
        _value = licenseUsecaseEnum.rawValue
    }
    
    /// Creates a new `LicenseUsecase` by decoding from the given decoder.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var value: String = try container.decode(String.self)
        if value.hasPrefix("custom:") {
            value = String(value.dropFirst("custom:".count))
        }
        do {
            let licenseUsecaseEnum = try LicenseUsecaseEnum.fromValue(value)
            _value = licenseUsecaseEnum.rawValue
        } catch {
            _value = "custom:\(value)"
        }
    }

    /// Encodes this `LicenseUsecase` into the given encoder.
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    /// A predefined use case for attribution.
    public static let attribution = LicenseUsecase(LicenseUsecaseEnum.attribution)
    /// A predefined use case for retargeting.
    public static let retargeting = LicenseUsecase(LicenseUsecaseEnum.retargeting)
    /// A predefined use case for personalization.
    public static let personalization = LicenseUsecase(LicenseUsecaseEnum.personalization)
    /// A predefined use case for AI training.
    public static let aiTraining = LicenseUsecase(LicenseUsecaseEnum.aiTraining)
    /// A predefined use case for distribution.
    public static let distribution = LicenseUsecase(LicenseUsecaseEnum.distribution)
    /// A predefined use case for analytics.
    public static let analytics = LicenseUsecase(LicenseUsecaseEnum.analytics)
    /// A predefined use case for support.
    public static let support = LicenseUsecase(LicenseUsecaseEnum.support)

}
