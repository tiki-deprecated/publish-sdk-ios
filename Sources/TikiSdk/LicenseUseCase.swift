import Foundation

/**
 Use case for license.
 
 - Parameter the license use case enumeration. Default value is nil.
 */
public class LicenseUsecase: Codable {
    
    private var _value: String
    
    /// The  String value
    public var value: String{
        return _value
    }
    
    public init(_ value: String){
        do {
           let licenseUsecaseEnum = try LicenseUsecaseEnum.fromValue(value: value)
            _value = licenseUsecaseEnum.rawValue
       } catch {
           _value = "custom:\(value)"
       }
    }
    
    public init(_ licenseUsecaseEnum: LicenseUsecaseEnum){
        _value = licenseUsecaseEnum.rawValue
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var value: String = try container.decode(String.self)
        if(value.hasPrefix("custom:")){
            value = String(value.dropFirst("custom:".count))
        }
        do {
           let licenseUsecaseEnum = try LicenseUsecaseEnum.fromValue(value: value)
            _value = licenseUsecaseEnum.rawValue
       } catch {
           _value = "custom:\(value)"
       }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    static let attribution = LicenseUsecase(LicenseUsecaseEnum.attribution)
    static let retargeting = LicenseUsecase(LicenseUsecaseEnum.retargeting)
    static let personalization = LicenseUsecase(LicenseUsecaseEnum.personalization)
    static let aiTraining = LicenseUsecase(LicenseUsecaseEnum.aiTraining)
    static let distribution = LicenseUsecase(LicenseUsecaseEnum.distribution)
    static let analytics = LicenseUsecase(LicenseUsecaseEnum.analytics)
    static let support = LicenseUsecase(LicenseUsecaseEnum.support)

}
