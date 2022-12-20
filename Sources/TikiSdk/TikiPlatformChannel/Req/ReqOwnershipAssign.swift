/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The request for the `assignOwnership` method call in the Platform Channel.
struct ReqOwnershipAssign: Req {
    let requestId, source : String
    let type : TikiSdkDataTypeEnum
    let contains : [String]
    let about, origin : String?
    
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
