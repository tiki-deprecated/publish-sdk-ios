/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation

enum OfferFlowStep{
    case none,
         prompt,
         terms,
         learnMore,
         endingAccepted,
         endingDeclined,
         endingError
}
