/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The request for the `assignOwnership` method call in the Platform Channel.
struct ReqOwnershipAssign: Encodable {
    let source : String
    let type : TikiSdkDataTypeEnum
    let contains : [String]
    let about, origin : String?
}
