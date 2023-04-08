/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import SwiftUI


/// The Tiki SDK theme for pre-built UIs.
///
/// The pre-built UI styles are defined by a `Theme` object. To configure a theme, use the `TikiSdk.instance.theme` property,
/// or chain calls to the `config()` method. For example:
///
/// ```
/// TikiSdk.config()
///     .theme
///         .primaryTextColor(.black)
///         .primaryBackgroundColor(.white)
///         .accentColor(.blue)
///         .fontFamily("test")
/// ```
///
/// To configure a dark theme, use the `TikiSdk.dark` property or chain calls to the `config()` method:
///
/// ```
/// TikiSdk.config()
///     .theme
///         .primaryTextColor(.black)
///         .primaryBackgroundColor(.white)
///         .accentColor(.blue)
///         .fontFamily("test")
///     .and()
///     .dark
///         .primaryTextColor(.white)
///         .primaryBackgroundColor(.black)
///         .accentColor(.white)
///         .fontFamily("test")
/// ```
///
/// The dark theme is only used if explicitly configured and if the OS is using a dark theme.
///
/// To configure fonts, first load the font files into the project bundle. The fonts should be added with their respective weights in the
/// filenames, like this:
///
/// * `<fontFamily>-Regular"`
/// * `<fontFamily>-Bold"`
/// * `<fontFamily>-Light"`
/// * `<fontFamily>-Medium"`
/// * `<fontFamily>-Bold"`
public class Theme {
    
    // MARK: Constant images
    
    /// Back arrow image, used in the `NavigationHeader` to dismiss the view.
    static let backArrow = Image("backArrow", bundle: .module)

    /// Green check icon, used in the `UsedFor` list for bullets.
    static let checkIcon = Image("checkIcon", bundle: .module)

    /// Question icon, used for the `LeanMoreButton`.
    static let questionIcon = Image("questionIcon", bundle: .module)

    /// Red X icon, used in the `UsedFor` list for bullets.
    static let xIcon = Image("xIcon", bundle: .module)
    
    // MARK: Default colors
    
    /// Primary text color. Used in default text items.
    public var primaryTextColor: Color { _primaryTextColor }
    
    /// Secondary text color. Used in specific text items. Defaults to `primaryTextColor` with 60% alpha transparency.
    public var secondaryTextColor: Color { _secondaryTextColor }
    
    /// Primary background color. The default color for backgrounds.
    public var primaryBackgroundColor: Color { _primaryBackgroundColor }
    
    /// Secondary background color.
    public var secondaryBackgroundColor: Color { _secondaryBackgroundColor }
    
    /// Accent color. Used to decorate or highlight items.
    public var accentColor: Color { _accentColor }
    
    // MARK: Fonts
    /// The `fontFamily` Regular variation.
    public var fontRegular: String {
        get{
            font["regular"]!
        }
    }
    /// The `fontFamily` Bold variation.
    public var fontBold: String {
        get{
            font["bold"]!
        }
    }
    /// The `fontFamily` Light variation.
    public var fontLight: String {
        get{
            font["light"]!
        }
    }
    /// The `fontFamily` Medium variation.
    public var fontMedium: String {
        get{
            font["medium"]!
        }
    }
    /// The `fontFamily` SemiBold variation.
    public var fontSemiBold: String {
        get {
            font["semiBold"]!
        }
    }
    
    
    // MARK: Instance Methods
    
    /// Sets the primary text color
    public func primaryTextColor(_ primaryTextColor: Color) -> Self {
        self._primaryTextColor = primaryTextColor
        return self
    }
    /// Sets the secondary text color
    public func secondaryTextColor(_ secondaryTextColor: Color) -> Self {
        self._secondaryTextColor = secondaryTextColor
        return self
    }
    /// Sets the primary background color
    public func primaryBackgroundColor(_ primaryBackgroundColor: Color) -> Self {
        self._primaryBackgroundColor = primaryBackgroundColor
        return self
    }
    /// Sets the secondary background color
    public func secondaryBackgroundColor(_ secondaryBackgroundColor: Color) -> Self {
        self._secondaryBackgroundColor = secondaryBackgroundColor
        return self
    }
    /// Sets the accent color
    public func accentColor(_ accentColor: Color) -> Self {
        self._accentColor = accentColor
        return self
    }
    /// Sets the font family
    public func fontFamily(_ fontFamily: String) -> Self {
        self._fontFamily = fontFamily
        return self
    }
    
    /// Returns the `TikiSdk` intance to simplify the chaining of methods in SDK configuration and initialization.
    public func and() -> TikiSdk {
        TikiSdk.instance
    }
    
    // MARK: Private properties
    
    private var _primaryTextColor = Color(red: 0.11, green: 0, blue: 0)
    private var _secondaryTextColor = Color(red: 0, green: 0, blue: 0).opacity(0.6)
    private var _primaryBackgroundColor = Color(red: 1, green: 1, blue: 1)
    private var _secondaryBackgroundColor = Color(red: 0.96, green:0.96, blue:0.96)
    private var _accentColor = Color(red: 0, green: 0.7, blue: 0.44)
    private var _fontFamily = "SpaceGrotesk"
    
    private var font: Dictionary<String,String> {
        get {[
            "regular" : "\(_fontFamily)-Regular",
            "bold" : "\(_fontFamily)-Bold",
            "light" : "\(_fontFamily)-Light",
            "medium" : "\(_fontFamily)-Medium",
            "semiBold" : "\(_fontFamily)-SemiBold",
        ]}
    }
    
}
