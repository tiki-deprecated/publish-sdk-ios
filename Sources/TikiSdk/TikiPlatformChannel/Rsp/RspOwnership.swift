/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

struct RspOwnership: Rsp {
    let requestId: String
    let ownership : TikiSdkOwnership
}
