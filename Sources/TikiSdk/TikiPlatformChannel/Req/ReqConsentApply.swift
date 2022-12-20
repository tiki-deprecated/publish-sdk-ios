/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The request for the `applyConsent` method call in the Platform Channel.
///
/// It uses the *source* and *destination* to verify if the consent was given.
struct ReqConsentApply: Req {
    let requestId, source: String
    let destination: TikiSdkDestination
    let origin: String?

    /// Converts this to a JSON String
    ///
    /// - Returns: valid json representation
    public func toJson() -> String{
        let encoder = JSONEncoder()
        do {
            return String(data: try encoder.encode(self), encoding: String.Encoding.utf8)!;
        } catch {
            objc_exception_rethrow()
        }
    }
}
