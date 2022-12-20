/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

struct RspError : Rsp {
    let requestId, message, stackTrace : String
}
