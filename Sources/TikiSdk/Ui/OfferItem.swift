/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation

/// An item that describes what can be done with the user data.
struct OfferItem{
    /// Description of the data usage.
    let description: String

    /// Whether this usage is allowed or not.
    let allow: Bool

}
