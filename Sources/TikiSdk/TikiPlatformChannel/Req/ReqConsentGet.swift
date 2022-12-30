/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation


/// The request for the `getConsent` call in the Platform Channel.
struct ReqConsentGet: Req {
    let source: String
    let origin: String?
}
