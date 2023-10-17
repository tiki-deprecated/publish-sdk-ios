/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

/// A use case for a license, describing how an asset may be used.
/// Use cases explicitly define how an asset may be used. Use either our list of common enumerations or define your
/// own using `UsecaseCommon`. Custom use cases can be created by using a value that does not match any of the predefined cases.
///
/// - Parameter value: The string value of the use case. If the value matches a predefined enumeration case, that case will be used;
/// otherwise, a custom use case will be created with the given value.
public class Usecase: Codable {
    let value: String
    
    private init(value: String) {
        self.value = value
    }
    
    public convenience init(usecase: UsecaseCommon) {
        self.init(value: usecase.rawValue)
    }
    
    public static func custom(usecase: String) -> Usecase {
        return Usecase(value: "custom:\(usecase)")
    }
    
    public static func from(usecase: String) -> Usecase {
        if let common = UsecaseCommon.from(usecase) {
            return Usecase(value: common.rawValue)
        } else if usecase.starts(with: "custom:") {
            return Usecase(value: usecase)
        } else {
            return custom(usecase: usecase)
        }
    }
    
    public func toString() -> String {
        return value
    }

}
