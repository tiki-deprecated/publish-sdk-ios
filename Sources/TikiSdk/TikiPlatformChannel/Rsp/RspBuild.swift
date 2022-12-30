/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The response for the `build` method call in the Platform Channel.
///
/// It returns the *address* of the built node.
struct RspBuild : Decodable {
    let address : String
}
