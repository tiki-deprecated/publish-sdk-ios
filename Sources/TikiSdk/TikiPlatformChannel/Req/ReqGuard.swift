/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqGuard: Encodable {
    var ptr: String?
    var uses = [LicenseUsecase]()
    var destinations: [String]?
    var origin: String?
}
