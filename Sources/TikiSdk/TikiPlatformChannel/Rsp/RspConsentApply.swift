/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The response for the `applyConsent` method call in the Platform Channel.
///
/// It returns if the consent was applied in the *success* field.
/// For failed requests, a *reason* should be provided.
struct RspConsentApply: Rsp {
    let requestId: String
    let success: Bool
    let reason: String?
}
