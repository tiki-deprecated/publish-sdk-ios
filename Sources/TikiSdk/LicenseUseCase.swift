import Foundation

/**
 Use case for license.
 
 - Parameter the license use case enumeration. Default value is nil.
 */
public class LicenseUsecase: Codable {
    
    private var customValue: String?
    private var licenseUsecaseEnum: LicenseUsecaseEnum?
    var value: String{
        return licenseUsecaseEnum?.value ?? customValue!
    }
    /**
     Creates a new instance of LicenseUsecase with a `LicenseUsecaseEnum` predefined value.
     
     - Parameter the license use case enumeration. Default value is nil.
     */
    init(_ licenseUsecase: LicenseUsecaseEnum? = nil){
        licenseUsecaseEnum = licenseUsecase
    }
    
    /**
     Creates a new instance of LicenseUsecase with custom value.
     
     - Parameter customUsecase: the custom use case for the license.
     */
    convenience init(customUsecase: String) {
        do {
            let licenseUsecaseEnum = try LicenseUsecaseEnum.fromValue(value: customUsecase)
            self.init(licenseUsecaseEnum)
        } catch {
            self.init()
            self.customValue = "custom:\(customUsecase)"
        }
    }

    static let attribution = LicenseUsecase(LicenseUsecaseEnum.attribution)
    static let retargeting = LicenseUsecase(LicenseUsecaseEnum.retargeting)
    static let personalization = LicenseUsecase(LicenseUsecaseEnum.personalization)
    static let aiTraining = LicenseUsecase(LicenseUsecaseEnum.aiTraining)
    static let distribution = LicenseUsecase(LicenseUsecaseEnum.distribution)
    static let analytics = LicenseUsecase(LicenseUsecaseEnum.analytics)
    static let support = LicenseUsecase(LicenseUsecaseEnum.support)

}
