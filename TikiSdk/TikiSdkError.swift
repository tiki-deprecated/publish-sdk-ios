/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import Foundation

/// A custom error type used by the TIKI SDK.
public struct TikiSdkError: Error {
    
    /// The error message associated with the error.
    var message: String?
    
    /// The stack trace associated with the error.
    var stackTrace: String?
    
    /// Initializes a new instance of `TikiSdkError`.
     
    /// - Parameters:
    ///     - message: A string containing the error message.
    ///     - stackTrace: A string containing the stack trace associated with the error.
    init(message: String?, stackTrace: String?) {
        self.message = message
        self.stackTrace = stackTrace
    }
}
