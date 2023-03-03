/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

/// The definition of the offer for data usage.
public struct OfferPrompt{
      /// A description of the data usage.
      ///
      /// It will occupy 3 lines maximum in the UI. An ellipsis will be added on overflow.
      /// Accepts basic markdown styles: underline, bold and italic.
    let description: String

      /// A image description of the data usage.
      ///
      /// Use a 320x100px image.
    let image: Image

      /// The list of items that describes what can be done with the user data.
      ///
      /// Maximum 3 items.
    let items: [OfferItem]
    
    /// The definition of the offer for data usage.
    /// - Parameters:
    ///   - description: A description of the data usage.
    ///   - image: A image description of the data usage.
    ///   - items: The list of items that describes what can be done with the user data. Max 3 items
    init(description: String, image: Image, items: [OfferItem]) throws{
        self.description = description
        self.image = image
        self.items = items
        if(items.count > 3){
            throw TikiSdkError(message: "Offer should have maximum 3 OfferItems. \(items.count) provided", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
    }
}
