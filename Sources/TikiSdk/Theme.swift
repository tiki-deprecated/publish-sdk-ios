/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import SwiftUI

/// Controls the UI theming for TikiSdk.
class Theme {
    public var primaryTextColor = Color(hex: 0x001C0000)
    public var primaryBackgroundColor = Color(hex: 0x001C1C1E)
    public var secondaryBackgroundColor = Color(hex: 0x00F6F6F6)
    public var accentColor = Color(hex: 0x0000B272)
    public var fontFamily = "";
    
    /// Builds the dark version of the theme.
    convenience init(dark: Bool = true) {
        self.init()
        self.primaryTextColor = Color(hex: 0x00F6F6F6)
        self.primaryBackgroundColor = Color(hex: 0x001C1C1E)
        self.secondaryBackgroundColor = Color(hex: 0x00F6F6F6).opacity(0.38)
        self.accentColor = Color(hex: 0x0000B272)
        self.fontFamily = "SpaceGrotesk"
    }
    
    /// Primary text color. Used in the default text items.
    var getPrimaryTextColor: Color { primaryTextColor }
    
    /// Secondary text color. Used in specific text items.
    ///
    /// Defaults to [primaryTextColor] with 60% alpha transparency.
    var getSecondaryTextColor: Color { primaryTextColor.opacity(0.6) }
    
    /// Primary background color. The default color for backgrounds.
    var getPrimaryBackgroundColor: Color { primaryBackgroundColor }
    
    /// Secondary background color.
    var getSecondaryBackgroundColor: Color { secondaryBackgroundColor }
    
    /// Accent color. Used to decorate or highlight items.
    var getAccentColor: Color { accentColor }
    
    /// The default font family for all texts.
    ///
    /// This should be set in the assets section of pubspec.yaml.
    var getFontFamily: String { fontFamily }
    
    
    func setPrimaryTextColor(_ primaryTextColor: Color) -> Self {
        self.primaryTextColor = primaryTextColor
        return self
    }
    
    func setPrimaryBackgroundColor(_ primaryBackgroundColor: Color) -> Self {
        self.primaryBackgroundColor = primaryBackgroundColor
        return self
    }
    
    func setSecondaryBackgroundColor(_ secondaryBackgroundColor: Color) -> Self {
        self.secondaryBackgroundColor = secondaryBackgroundColor
        return self
    }
    
    func setAccentColor(_ accentColor: Color) -> Self {
        self.accentColor = accentColor
        return self
    }
    
    func setFontFamily(_ fontFamily: String) -> Self {
        self.fontFamily = fontFamily
        return self
    }
    
    func and() -> TikiSdk {
        TikiSdk.instance
    }
}

extension Color {
    init(hex: UInt32) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B)
    }
}

