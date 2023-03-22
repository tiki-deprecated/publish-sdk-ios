/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The type of data origin for an ownership registry.
public enum CoreMethod: String, Codable{
    case build  = "build"
    case license = "license"
    case latest = "latest"
    case all = "all"
    case getLicense = "getLicense"
    case title = "title"
    case getTitle = "getTitle"
    case `guard` = "guard"
}
