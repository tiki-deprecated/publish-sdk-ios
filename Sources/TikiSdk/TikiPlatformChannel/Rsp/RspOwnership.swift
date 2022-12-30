/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The response for the `assignOwnership` and `getOwnership` method calls in
/// the Platform Channel.
///
/// Returns the *ownership* or Null if not found.
struct RspOwnership : Decodable {
    let ownership : TikiSdkOwnership
}
