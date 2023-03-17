import Foundation

/**
 
 Default accepted usecases
 */
public enum LicenseUsecaseEnum: String, Codable, CaseIterable {
    case attribution = "attribution"
    case retargeting = "retargeting"
    case personalization = "personalization"
    case aiTraining = "ai_training"
    case distribution = "distribution"
    case analytics = "analytics"
    case support = "support"
    
    /**
     Returns the string value for the enum
     */
    var value: String {
        return self.rawValue
    }
    
    ///
    ///     Builds a `LicenseUsecaseEnum` from `value`.
    ///
    ///    - Parameter value: string value of enum.
    ///    - Throws: `NSException` if `value` is not a valid `LicenseUsecaseEnum` value.
    ///
    ///     - Returns: `LicenseUsecase
    
    static func fromValue(value: String) throws -> LicenseUsecaseEnum {
        for type in LicenseUsecaseEnum.allCases {
            if type.rawValue == value {
                return type
            }
        }
        throw NSError(domain: "Invalid LicenseUsecaseEnum value \(value)", code: 0, userInfo: nil)
    }
}



