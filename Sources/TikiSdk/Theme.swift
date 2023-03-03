/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import SwiftUI

/// Controls the UI theming for TikiSdk.
public class Theme {
    public var primaryTextColor = Color(hex: 0x001C0000)
    public var primaryBackgroundColor = Color(hex: 0x001C1C1E)
    public var secondaryBackgroundColor = Color(hex: 0x00F6F6F6)
    public var accentColor = Color(hex: 0x0000B272)
    public var fontFamily = "";
    
    /// Builds the dark version of the theme.
    public convenience init(dark: Bool = true) {
        self.init()
        self.primaryTextColor = Color(hex: 0x00F6F6F6)
        self.primaryBackgroundColor = Color(hex: 0x001C1C1E)
        self.secondaryBackgroundColor = Color(hex: 0x00F6F6F6).opacity(0.38)
        self.accentColor = Color(hex: 0x0000B272)
        self.fontFamily = "SpaceGrotesk"
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

public extension Color {
    init(hex: UInt32) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B)
    }
}

