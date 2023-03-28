/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation

/// An enumeration of accepted tags for `TitleTag`
public enum TitleTagEnum: String, Codable, CaseIterable {
    case emailAddress = "email_address"
    case phoneNumber = "phone_number"
    case physicalAddress = "physical_address"
    case contactInfo = "contact_info"
    case health = "health"
    case fitness = "fitness"
    case paymentInfo = "payment_info"
    case creditInfo = "credit_info"
    case financialInfo = "financial_info"
    case preciseLocation = "precise_location"
    case coarseLocation = "coarse_location"
    case sensitiveInfo = "sensitive_info"
    case contacts = "contacts"
    case messages = "messages"
    case photoVideo = "photo_video"
    case audio = "audio"
    case gameplayContent = "gameplay_content"
    case customerSupport = "customer_support"
    case userContent = "user_content"
    case browsingHistory = "browsing_history"
    case searchHistory = "search_history"
    case userId = "user_id"
    case deviceId = "device_id"
    case purchaseHistory = "purchase_history"
    case productInteraction = "product_interaction"
    case advertisingData = "advertising_data"
    case usageData = "usage_data"
    case crashData = "crash_data"
    case performanceData = "performance_data"
    case diagnosticData = "diagnostic_data"
    
    /// Builds a `TitleTagEnum` from `value`.
    ///
    /// - Parameter value: The string value of the tag.
    /// - Throws: An `NSError` if `value` is not a valid `TitleTagEnum` value.
    /// - Returns: A `TitleTagEnum` value corresponding to the given `value`.
    public static func fromValue(value: String) throws -> TitleTagEnum {
        for type in TitleTagEnum.allCases {
            if type.rawValue == value {
                return type
            }
        }
        throw NSError(domain: "Invalid TitleTagEnum value \(value)", code: 0, userInfo: nil)
    }
}
