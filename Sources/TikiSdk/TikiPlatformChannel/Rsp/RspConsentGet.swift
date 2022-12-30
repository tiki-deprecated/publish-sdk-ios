/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The response for the `getConsent` and `modifyConsent`method calls in
/// the Platform Channel.
///
/// It returns the *consent*. Null if no consent was given.
struct RspConsentGet : Decodable {
    let consent : TikiSdkConsent
}
