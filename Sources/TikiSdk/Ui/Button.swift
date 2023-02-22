/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

/// The button used in Tiki SDK UIs.
struct Button: View {
    
    /// The text of the button.
    let text: String

    /// The callback function for button tap.
    let callback: () -> Void

    /// The font family of the button's text from pubspec. Default is `SpaceGrotesk`
    let font: Font

    /// The button's background color.
    let backgroundColor: Color

    /// The button's border color.
    let borderColor: Color

    /// The button's text color.
    let textColor: Color
    
    /// Initializes a colored button with white text.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button
    ///   - callback: "On tap" callback
    ///   - color: The color of the button
    ///   - font: The font to be used. Default is `SpaceGrotesk` 20pt.
    init(text: String, callback: @escaping () -> Void, color: Color, font: Font = Font.custom("SpaceGrotesk", size: 20)){
        self.backgroundColor = color
        self.borderColor = color
        self.textColor = Color(white: 1.0)
        self.text = text
        self.callback = callback
        self.font = font
    }
    
    /// Initializes an outlined button.
    ///
    /// - Parameters:
    ///   - text:  Text displayed in the button
    ///   - callback: "On tap" callback
    ///   - textColor: The color of the button's text
    ///   - borderColor: The border color
    ///   - font: The font to be used. Default is `SpaceGrotesk` 20pt.
    init(text: String, callback: @escaping () -> Void, textColor: Color, borderColor: Color, font: Font = Font.custom("SpaceGrotesk", size: 20)){
        self.backgroundColor = Color(white: 1.0)
        self.borderColor = borderColor
        self.textColor = textColor
        self.text = text
        self.callback = callback
        self.font = font
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Button(text: "Test Btn", callback: {print("ok")}, color: Color.blue)
    }
}
