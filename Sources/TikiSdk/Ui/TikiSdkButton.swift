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
    var font: String?
    
    /// The default constructor for outlined button.
    ///
    /// [TikiSdk.theme] is used for default styling.
    public init(_ text: String, _ onTap: @escaping () -> Void,
         textColor: Color,
         borderColor: Color,
         font: String? = nil) {
        self.text = text
        self.onTap = onTap
        self.textColor = textColor
        self.borderColor = borderColor
        self.font = font
        self.backgroundColor = Color.white
    }
    
    /// The constructor for a solid color button.
    ///
    /// [TikiSdk.theme] is used for default styling.
    public init(_ text: String, _ onTap: @escaping () -> Void,
         color: Color,
         font: String? = nil) {
        self.text = text
        self.onTap = onTap
        self.textColor = Color.white
        self.backgroundColor = color
        self.borderColor = color
        self.font = font
    }
    
    public var body: some View {
        
        VStack{
            Text(text)
                .font(.custom(font ?? TikiSdk.theme(colorScheme).fontMedium, size: 20))
                .lineSpacing(1.2)
                .foregroundColor(textColor ?? TikiSdk.theme(colorScheme).primaryTextColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 14)
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
