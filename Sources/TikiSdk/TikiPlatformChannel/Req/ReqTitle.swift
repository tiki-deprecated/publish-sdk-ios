/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct ReqTitle: Encodable {
    var ptr: String?
    var tags: [TitleTag] = []
    var description: String?
    var origin: String?
}
