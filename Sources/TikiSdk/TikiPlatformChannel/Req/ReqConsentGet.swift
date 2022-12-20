/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqConsentGet: Req {
    let requestId, source: String
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
