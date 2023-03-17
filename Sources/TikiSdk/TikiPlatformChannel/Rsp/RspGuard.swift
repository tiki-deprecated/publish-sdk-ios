/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

struct RspGuard: Decodable{
    let success: Bool
    let reason: String?
}
