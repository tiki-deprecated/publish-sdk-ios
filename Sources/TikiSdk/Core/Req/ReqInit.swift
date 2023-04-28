/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// The request for the `build` method call in the Platform Channel.
///
/// It requires an *publishingId]* and an *origin]*. If no *address* is provided the SDK
/// will create a new one
struct ReqInit: Encodable {
    let publishingId : String
    let id : String
    let origin : String
    let dbDir: String
}
