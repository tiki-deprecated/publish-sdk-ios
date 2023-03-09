/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI

struct TikiSdkButton: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    /// The button's text label.
    let text: String
    
    /// The function to be called on user tap.
    let onTap: () -> Void
    
    /// The button's background color.
    var backgroundColor: Color?
    
    /// The button's border color.
    var borderColor: Color?
    
    /// The button's text color.
    var textColor: Color?
    
    /// The font family of the button's text from pubspec.
    var fontFamily: String?
    
    /// The default constructor for outlined button.
    ///
    /// [TikiSdk.theme] is used for default styling.
    init(_ text: String, _ onTap: @escaping () -> Void,
         textColor: Color? = nil,
         borderColor: Color? = nil,
         fontFamily: String? = nil) {
        self.text = text
        self.onTap = onTap
        self.textColor = textColor
        self.borderColor = borderColor
        self.fontFamily = fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily
        self.backgroundColor = Color.white
    }
    
    /// The constructor for a solid color button.
    ///
    /// [TikiSdk.theme] is used for default styling.
    init(solid text: String, _ onTap: @escaping () -> Void,
         color: Color? = nil,
         fontFamily: String? = nil) {
        self.text = text
        self.onTap = onTap
        self.backgroundColor = color ?? TikiSdk.instance.getActiveTheme(colorScheme).accentColor
        self.borderColor = color ?? TikiSdk.instance.getActiveTheme(colorScheme).accentColor
        self.fontFamily = fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily
    }
    
    var body: some View {
        Button(action: onTap) {
            if #available(iOS 14.0, *) {
                Text(text)
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .lineSpacing(1.2)
                    .foregroundColor(textColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor)
                    .font(.custom(fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily,
                                  size: 20, relativeTo: .headline)
                    )
            } else {
                Text(text)
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .lineSpacing(1.2)
                    .foregroundColor(textColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor)
            }
        }
        .padding(.all, 14)
        .background(backgroundColor)
        .border(borderColor ?? Color.black.opacity(0.26), width: 1)
        .cornerRadius(10)
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        TikiSdkButton("Test", {print("teste")})
    }
}
