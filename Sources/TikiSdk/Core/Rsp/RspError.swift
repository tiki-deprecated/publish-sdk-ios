/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

struct RspError : Decodable {
    let message, stackTrace : String
}
