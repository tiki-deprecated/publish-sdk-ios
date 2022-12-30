/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The request for the `getOwnership` method call in the Platform Channel.
struct ReqOwnershipGet: Req {
    let source: String
    let origin: String?
}
