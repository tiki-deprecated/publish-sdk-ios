/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The type of data origin for an ownership registry.
public protocol ChannelMethod {
    func value() -> String
}
