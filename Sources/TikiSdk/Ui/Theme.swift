/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import SwiftUI

/// Controls the UI theming for TikiSdk.
public class Theme {
    var _primaryTextColor = Color(red: 0, green: 0, blue: 0)
    var _secondaryTextColor = Color(red: 0, green: 0, blue: 0).opacity(0.6)
    var _primaryBackgroundColor = Color(red: 1, green: 1, blue: 1)
    var _secondaryBackgroundColor = Color(red: 0.96, green:0.96, blue:0.96)
    var _accentColor = Color(red: 0, green: 0.7, blue: 0.44)
    var _fontFamily = "SpaceGrotesk"
    
    var font: Dictionary<String,String> {
        get {[
            "regular" : "\(_fontFamily)-Regular",
            "bold" : "\(_fontFamily)-Bold",
            "light" : "\(_fontFamily)-Light",
            "medium" : "\(_fontFamily)-Medium",
            "semiBold" : "\(_fontFamily)-SemiBold",
        ]}
    }
    
    /// Primary text color. Used in the default text items.
    public var primaryTextColor: Color { _primaryTextColor }
    
    /// Secondary text color. Used in specific text items.
    ///
    /// Defaults to [primaryTextColor] with 60% alpha transparency.
    public var secondaryTextColor: Color { _secondaryTextColor }
    
    /// Primary background color. The default color for backgrounds.
    public var primaryBackgroundColor: Color { _primaryBackgroundColor }
    
    /// Secondary background color.
    public var secondaryBackgroundColor: Color { _secondaryBackgroundColor }
    
    /// Accent color. Used to decorate or highlight items.
    public var accentColor: Color { _accentColor }
    
    public var fontRegular: String {
        get{
            font["regular"]!
        }
    }
    public var fontBold: String {
        get{
            font["bold"]!
        }
    }
    public var fontLight: String {
        get{
            font["light"]!
        }
    }
    public var fontMedium: String {
        get{
            font["medium"]!
        }
    }
    public var fontSemiBold: String {
        get {
            font["semiBold"]!
        }
    }
    
    public func primaryTextColor(_ primaryTextColor: Color) -> Self {
        self._primaryTextColor = primaryTextColor
        return self
    }
    
    public func secondaryTextColor(_ secondaryTextColor: Color) -> Self {
        self._secondaryTextColor = secondaryTextColor
        return self
    }
    
    public func primaryBackgroundColor(_ primaryBackgroundColor: Color) -> Self {
        self._primaryBackgroundColor = primaryBackgroundColor
        return self
    }
    
    public func secondaryBackgroundColor(_ secondaryBackgroundColor: Color) -> Self {
        self._secondaryBackgroundColor = secondaryBackgroundColor
        return self
    }
    
    public func accentColor(_ accentColor: Color) -> Self {
        self._accentColor = accentColor
        return self
    }
    
    public func fontFamily(_ fontFamily: String) -> Self {
        self._fontFamily = fontFamily
        return self
    }
    
    public func and() -> TikiSdk {
        TikiSdk.instance
    }
}
