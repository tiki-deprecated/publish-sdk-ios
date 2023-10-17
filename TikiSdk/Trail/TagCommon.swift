/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

public enum TagCommon: String, CaseIterable {
    case EMAIL_ADDRESS = "email_address"
    case PHONE_NUMBER = "phone_number"
    case PHYSICAL_ADDRESS = "physical_address"
    case CONTACT_INFO = "contact_info"
    case HEALTH = "health"
    case FITNESS = "fitness"
    case PAYMENT_INFO = "payment_info"
    case CREDIT_INFO = "credit_info"
    case FINANCIAL_INFO = "financial_info"
    case PRECISE_LOCATION = "precise_location"
    case COARSE_LOCATION = "coarse_location"
    case SENSITIVE_INFO = "sensitive_info"
    case CONTACTS = "contacts"
    case MESSAGES = "messages"
    case PHOTO_VIDEO = "photo_video"
    case AUDIO = "audio"
    case GAMEPLAY_CONTENT = "gameplay_content"
    case CUSTOMER_SUPPORT = "customer_support"
    case USER_CONTENT = "user_content"
    case BROWSING_HISTORY = "browsing_history"
    case SEARCH_HISTORY = "search_history"
    case USER_ID = "user_id"
    case DEVICE_ID = "device_id"
    case PURCHASE_HISTORY = "purchase_history"
    case PRODUCT_INTERACTION = "product_interaction"
    case ADVERTISING_DATA = "advertising_data"
    case USAGE_DATA = "usage_data"
    case CRASH_DATA = "crash_data"
    case PERFORMANCE_DATA = "performance_data"
    case DIAGNOSTIC_DATA = "diagnostic_data"
    
    /// Builds a `TagCommon` from `value`.
    ///
    /// - Parameter value: The string value of the tag.
    /// - Returns: A `TagCommon` value corresponding to the given `value`.
    public static func from(value: String) -> TagCommon? {
        for type in TagCommon.allCases {
            if type.rawValue == value {
                return type
            }
        }
        return nil
    }
}
