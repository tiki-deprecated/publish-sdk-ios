/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation
import Foundation

/// Title tag
///
/// A `TitleTag` object represents a tag that describes a data asset included in a `TitleRecord`.
/// Tags improve record searchability and come in handy when bulk searching and filtering licenses.
///
/// You can use our list of common enumerations or define your own using the `customValue` parameter
/// as a constructor parameter.
public class TitleTag: Codable {

    private var _value: String

    /// The string value of the `TitleTag`.
    public var value: String {
        return _value
    }

    /// Initializes a `TitleTag` with the given value.
    ///
    /// - Parameter value: The string value of the `TitleTag`.
    public init(_ value: String) {
        do {
            let titleTagEnum = try TitleTagEnum.fromValue(value: value)
            _value = titleTagEnum.rawValue
        } catch {
            _value = "custom:\(value)"
        }
    }

    /// Initializes a `TitleTag` with the given `TitleTagEnum` value.
    ///
    /// - Parameter titleTagEnum: The `TitleTagEnum` value of the `TitleTag`.
    public init(_ titleTagEnum: TitleTagEnum) {
        _value = titleTagEnum.rawValue
    }

    /// Initializes a new instance of the `TitleTag` class from a decoder.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var value: String = try container.decode(String.self)
        if(value.hasPrefix("custom:")) {
            value = String(value.dropFirst("custom:".count))
        }
        do {
            let titleTagEnum = try TitleTagEnum.fromValue(value: value)
            _value = titleTagEnum.rawValue
        } catch {
            _value = "custom:\(value)"
        }
    }

    /// Encodes the `TitleTag` object to a encoder.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    /// The common `TitleTag` representing an email address.
    public static let emailAddress = TitleTag(TitleTagEnum.emailAddress)

    /// The common `TitleTag` representing a phone number.
    public static let phoneNumber = TitleTag(TitleTagEnum.phoneNumber)

    /// The common `TitleTag` representing a physical address.
    public static let physicalAddress = TitleTag(TitleTagEnum.physicalAddress)

    /// The common `TitleTag` representing a contact information.
    public static let contactInfo = TitleTag(TitleTagEnum.contactInfo)

    /// The common `TitleTag` representing health information.
    public static let health = TitleTag(TitleTagEnum.health)

    /// The common `TitleTag` representing fitness information.
    public static let fitness = TitleTag(TitleTagEnum.fitness)

    /// The common `TitleTag` representing payment information.
    public static let paymentInfo = TitleTag(TitleTagEnum.paymentInfo)

    /// The common `TitleTag` representing credit information.
    public static let creditInfo = TitleTag(TitleTagEnum.creditInfo)

    /// The common `TitleTag` representing financial information.
    public static let financialInfo = TitleTag(TitleTagEnum.financialInfo)

    /// The common `TitleTag` representing a precise location.
    public static let preciseLocation = TitleTag(TitleTagEnum.preciseLocation)

    /// The common `TitleTag` representing a coarse location.
    public static let coarseLocation = TitleTag(TitleTagEnum.coarseLocation)
    
    /// The common `TitleTag` representing a sensitive info.
    public static let sensitiveInfo = TitleTag(TitleTagEnum.sensitiveInfo)
    
    /// The common `TitleTag` representing contacts.
    public static let contacts = TitleTag(TitleTagEnum.contacts)
    
    /// The common `TitleTag` representing messages.
    public static let messages = TitleTag(TitleTagEnum.messages)
    
    /// The common `TitleTag` representing photo and/or video.
    public static let photoVideo = TitleTag(TitleTagEnum.photoVideo)
    
    /// The common `TitleTag` representing a audio.
    public static let audio = TitleTag(TitleTagEnum.audio)
    
    /// The common `TitleTag` representing a gameplay content.
    public static let gameplayContent = TitleTag(TitleTagEnum.gameplayContent)
    
    /// The common `TitleTag` representing customer support.
    public static let customerSupport = TitleTag(TitleTagEnum.customerSupport)
    
    /// The common `TitleTag` representing user content.
    public static let userContent = TitleTag(TitleTagEnum.userContent)
    
    /// The common `TitleTag` representing browsing history.
    public static let browsingHistory = TitleTag(TitleTagEnum.browsingHistory)
    
    /// The common `TitleTag` representing a search history.
    public static let searchHistory = TitleTag(TitleTagEnum.searchHistory)
    
    /// The common `TitleTag` representing an user id.
    public static let userId = TitleTag(TitleTagEnum.userId)
    
    /// The common `TitleTag` representing a device id.
    public static let deviceId = TitleTag(TitleTagEnum.deviceId)
    
    /// The common `TitleTag` representing a purchase history.
    public static let purchaseHistory = TitleTag(TitleTagEnum.purchaseHistory)
    
    /// The common `TitleTag` representing a product interaction.
    public static let productInteraction = TitleTag(TitleTagEnum.productInteraction)
    
    /// The common `TitleTag` representing advertising data.
    public static let advertisingData = TitleTag(TitleTagEnum.advertisingData)
    
    /// The common `TitleTag` representing usage data.
    public static let usageData = TitleTag(TitleTagEnum.usageData)
    
    /// The common `TitleTag` representing crash data.
    public static let crashData = TitleTag(TitleTagEnum.crashData)
    
    /// The common `TitleTag` representing performance data.
    public static let performanceData = TitleTag(TitleTagEnum.performanceData)
    
    /// The common `TitleTag` representing diagnostic data.
    public static let diagnosticData = TitleTag(TitleTagEnum.diagnosticData)
    
}
