import Foundation

/**
 Use case for license.
 
 - Parameter the license use case enumeration. Default value is nil.
 */
public class LicenseUsecase: Codable {
    
    private var customValue: String?
    private var usecaseEnum: LicenseUsecaseEnum?
    
    /// The Usecase String value
    public var value: String{
        return usecaseEnum?.rawValue ?? customValue!
    }
    
    public init(_ usecase: String) {
        do {
            self.usecaseEnum = try LicenseUsecaseEnum.fromValue(value: usecase)
        } catch {
            self.customValue = "custom:\(usecase)"
        }
    }
    
    public convenience init(_ usecase: LicenseUsecaseEnum){
        self.init(usecase.rawValue)
    }
    

    static let attribution = LicenseUsecase(LicenseUsecaseEnum.attribution)
    static let retargeting = LicenseUsecase(LicenseUsecaseEnum.retargeting)
    static let personalization = LicenseUsecase(LicenseUsecaseEnum.personalization)
    static let aiTraining = LicenseUsecase(LicenseUsecaseEnum.aiTraining)
    static let distribution = LicenseUsecase(LicenseUsecaseEnum.distribution)
    static let analytics = LicenseUsecase(LicenseUsecaseEnum.analytics)
    static let support = LicenseUsecase(LicenseUsecaseEnum.support)

}
