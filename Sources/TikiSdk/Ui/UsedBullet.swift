
/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// An item that describes what can be done with the user data.
class UsedBullet {
  /// Description of the data usage.
  let text: String
  
  /// Whether it is used.
  let isUsed: Bool
  
  init(text: String, isUsed: Bool) {
    self.text = text
    self.isUsed = isUsed
  }
}
