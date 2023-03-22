
/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// An item that describes what can be done with the user data.
public struct Bullet: Hashable {
    
  public init(text: String, isUsed: Bool) {
    self.text = text
    self.isUsed = isUsed
  }
    
  /// Description of the data usage.
  public let text: String
  
  /// Whether it is used.
  public let isUsed: Bool
}
