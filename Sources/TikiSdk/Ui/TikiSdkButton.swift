/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI

public struct TikiSdkButton: View {
    
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
    public init(_ text: String, _ onTap: @escaping () -> Void,
         textColor: Color,
         borderColor: Color,
         fontFamily: String? = nil) {
        self.text = text
        self.onTap = onTap
        self.textColor = textColor
        self.borderColor = borderColor
        self.fontFamily = fontFamily
        self.backgroundColor = Color.white
    }
    
    /// The constructor for a solid color button.
    ///
    /// [TikiSdk.theme] is used for default styling.
    public init(_ text: String, _ onTap: @escaping () -> Void,
         color: Color,
         fontFamily: String? = nil) {
        self.text = text
        self.onTap = onTap
        self.textColor = Color.white
        self.backgroundColor = color
        self.borderColor = color
        self.fontFamily = fontFamily
    }
    
    public var body: some View {
        
        VStack{
            Text(text)
                .fontWeight(.semibold)
                .font(fontFamily != nil ? .custom(fontFamily!, size: 20) : .system(size: 20))
                .lineSpacing(1.2)
                .foregroundColor(textColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor)
                .font(.custom(fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily, size: 20)
                )
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .background(backgroundColor)
        .cornerRadius(10)
        .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor!, lineWidth: 1)
                )
        .onTapGesture() {
            onTap()
        }
    }
}
