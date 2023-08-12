/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqGuard: Encodable {
    var ptr: String
    var usercases: [LicenseUsecase]
    var destinations: [String]? = nil
    var origin: String
}
