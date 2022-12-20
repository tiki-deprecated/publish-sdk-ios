/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

struct RspConsentGet : Rsp {
    let requestId: String
    let consent : TikiSdkConsent
}
