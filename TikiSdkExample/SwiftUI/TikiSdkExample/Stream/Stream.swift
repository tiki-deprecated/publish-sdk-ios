/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

struct Stream{
    let source: String
    let body: String = "{\"message\" : \"Hello Tiki!\"}"
    var httpMethod: String = "POST"
    var interval: Int = 1
    var url: String = "https://postman-echo.com/post"
}
