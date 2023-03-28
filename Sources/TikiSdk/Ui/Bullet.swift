/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

// A representation of data usage permission.
public struct Bullet: Hashable {

    /// Creates a new bullet item with the given description and usage status.
    /// - Parameters:
    ///     - text: A string that describes the usage of the data.
    ///     - isUsed: A boolean value that indicates whether the data is being used.
    public init(text: String, isUsed: Bool) {
        self.text = text
        self.isUsed = isUsed
    }

    /// A string that describes the usage of the data.
    public let text: String

    /// A boolean value that indicates whether the data is being used.
    public let isUsed: Bool
}
