/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The response for the errors thrown in the Platform Channel.
///
/// It returns the *message* of the error and the String representation of the
/// *stackTrace*
struct RspError : Rsp {
    let requestId, message, stackTrace : String
}
