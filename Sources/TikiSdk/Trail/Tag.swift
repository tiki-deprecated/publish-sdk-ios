/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

class Tag {
    let value: String
    
    private init(value: String) {
        self.value = value
    }
    
    convenience init(tag: TagCommon) {
        self.init(value: tag.rawValue)
    }
    
    static func custom(tag: String) -> Tag {
        return Tag(value: "custom:\(tag)")
    }
    
    static func from(tag: String) -> Tag {
        if let common = TagCommon.from(value: tag) {
            return Tag(value: common.rawValue)
        } else if tag.starts(with: "custom:") {
            return Tag(value: tag)
        } else {
            return custom(tag: tag)
        }
    }
}
