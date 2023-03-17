import Foundation


/// Title tag
///
/// Tags are included in the [TitleRecord] and describe the represented data asset.
/// Tags improve record searchability and come in handy when bulk searching and filtering licenses.
/// Use either our list of common enumerations or define your own using [customValue] as constructor
/// parameter.
public class TitleTag: Codable {
    
    private var customValue: String?
    private var titleTagEnum: TitleTagEnum?
    
    /// The TitleTag String value
    public var value: String{
        return titleTagEnum?.rawValue ?? customValue!
    }
    
    public init(_ titleTag: String) {
        do {
            self.titleTagEnum = try TitleTagEnum.fromValue(value: titleTag)
        } catch {
            self.customValue = "custom:\(titleTag)"
        }
    }
    
    public convenience init(_ titleTag: TitleTagEnum){
        self.init(titleTag.rawValue)
    }
    
    public static let emailAddress = TitleTag(TitleTagEnum.emailAddress)
    public static let phoneNumber = TitleTag(TitleTagEnum.phoneNumber)
    public static let physicalAddress = TitleTag(TitleTagEnum.physicalAddress)
    public static let contactInfo = TitleTag(TitleTagEnum.contactInfo)
    public static let health = TitleTag(TitleTagEnum.health)
    public static let fitness = TitleTag(TitleTagEnum.fitness)
    public static let paymentInfo = TitleTag(TitleTagEnum.paymentInfo)
    public static let creditInfo = TitleTag(TitleTagEnum.creditInfo)
    public static let financialInfo = TitleTag(TitleTagEnum.financialInfo)
    public static let preciseLocation = TitleTag(TitleTagEnum.preciseLocation)
    public static let coarseLocation = TitleTag(TitleTagEnum.coarseLocation)
    public static let sensitiveInfo = TitleTag(TitleTagEnum.sensitiveInfo)
    public static let contacts = TitleTag(TitleTagEnum.contacts)
    public static let messages = TitleTag(TitleTagEnum.messages)
    public static let photoVideo = TitleTag(TitleTagEnum.photoVideo)
    public static let audio = TitleTag(TitleTagEnum.audio)
    public static let gameplayContent = TitleTag(TitleTagEnum.gameplayContent)
    public static let customerSupport = TitleTag(TitleTagEnum.customerSupport)
    public static let userContent = TitleTag(TitleTagEnum.userContent)
    public static let browsingHistory = TitleTag(TitleTagEnum.browsingHistory)
    public static let searchHistory = TitleTag(TitleTagEnum.searchHistory)
    public static let userId = TitleTag(TitleTagEnum.userId)
    public static let deviceId = TitleTag(TitleTagEnum.deviceId)
    public static let purchaseHistory = TitleTag(TitleTagEnum.purchaseHistory)
    public static let productInteraction = TitleTag(TitleTagEnum.productInteraction)
    public static let advertisingData = TitleTag(TitleTagEnum.advertisingData)
    public static let usageData = TitleTag(TitleTagEnum.usageData)
    public static let crashData = TitleTag(TitleTagEnum.crashData)
    public static let performanceData = TitleTag(TitleTagEnum.performanceData)
    public static let diagnosticData = TitleTag(TitleTagEnum.diagnosticData)
}
