/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqGuard: Encodable {
    var ptr: String?
    var usecases = [LicenseUsecase]()
    var destinations: [String]?
    var origin: String?
}
