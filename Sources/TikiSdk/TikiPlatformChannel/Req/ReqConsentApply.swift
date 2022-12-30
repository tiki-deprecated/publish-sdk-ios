/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The request for the `applyConsent` method call in the Platform Channel.
///
/// It uses the *source* and *destination* to verify if the consent was given.
struct ReqConsentApply: Encodable {
    let source: String
    let destination: TikiSdkDestination
    let origin: String?
}
