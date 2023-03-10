/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import SwiftUI

/// Controls the UI theming for TikiSdk.
public class Theme {
    public var primaryTextColor = Color(red: 0, green: 0, blue: 0)
    public var primaryBackgroundColor = Color(red: 1, green: 1, blue: 1)
    public var secondaryBackgroundColor = Color(red: 0.96, green:0.96, blue:0.96)
    public var accentColor = Color(red: 0, green: 0.7, blue: 0.44)
    public var fontFamily = "SpaceGrotesk-Regular";
    
    /// Builds the dark version of the theme.
    public convenience init(dark: Bool = true) {
        self.init()
        self.fontFamily = "SpaceGrotesk-Regular"
    }
    
    /// Primary text color. Used in the default text items.
    public var getPrimaryTextColor: Color { primaryTextColor }
    
    /// Secondary text color. Used in specific text items.
    ///
    /// Defaults to [primaryTextColor] with 60% alpha transparency.
    public var getSecondaryTextColor: Color { primaryTextColor.opacity(0.6) }
    
    /// Primary background color. The default color for backgrounds.
    public var getPrimaryBackgroundColor: Color { primaryBackgroundColor }
    
    /// Secondary background color.
    public var getSecondaryBackgroundColor: Color { secondaryBackgroundColor }
    
    /// Accent color. Used to decorate or highlight items.
    public var getAccentColor: Color { accentColor }
    
    /// The default font family for all texts.
    ///
    /// This should be set in the assets section of pubspec.yaml.
    public var getFontFamily: String { fontFamily }
    
    
    public func setPrimaryTextColor(_ primaryTextColor: Color) -> Self {
        self.primaryTextColor = primaryTextColor
        return self
    }
    
    public func setPrimaryBackgroundColor(_ primaryBackgroundColor: Color) -> Self {
        self.primaryBackgroundColor = primaryBackgroundColor
        return self
    }
    
    public func setSecondaryBackgroundColor(_ secondaryBackgroundColor: Color) -> Self {
        self.secondaryBackgroundColor = secondaryBackgroundColor
        return self
    }
    
    public func setAccentColor(_ accentColor: Color) -> Self {
        self.accentColor = accentColor
        return self
    }
    
    public func setFontFamily(_ fontFamily: String) -> Self {
        self.fontFamily = fontFamily
        return self
    }
    
    public func and() -> TikiSdk {
        TikiSdk.instance
    }
}

