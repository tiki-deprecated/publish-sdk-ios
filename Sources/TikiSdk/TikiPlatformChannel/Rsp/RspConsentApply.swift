/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

struct RspConsentApply: Rsp {
    let requestId: String
    let success: Bool
    let reason: String?
}
