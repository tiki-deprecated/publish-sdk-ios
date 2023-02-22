//
//  SwiftUIView.swift
//  
//
//  Created by Ricardo on 22/02/23.
//

import SwiftUI


struct TextViewer: View {
    /// The color that will be used in the color Button.
    let accentColor: Color

    /// The text color.
    let primaryColor: Color

    /// The color used in background and in color Button text.
    let backgroundColor: Color

    /// The text to be shown in the viewer.
    let text: String

    /// The fontFamily from pubspec.
    let font: Font

    /// The button text.
    let buttonText: String

    /// The callback function to the button tap.
    ///
    /// If nil, the button will not be shown.
    let callback: (() -> Void)?
 
    init(
        text: String,
        callback: (() -> Void)? = nil,
        buttonText: String = "I agree",
        accentColor: Color = Color(hex: 0x0024956a),
        primaryColor: Color = Color(hex: 0x002D2D2D),
        backgroundColor: Color = Color(hex: 0x00ffffff),
        font: Font = Font.custom("SpaceGrotesk", size: 20)
    ){
        self.text = text
        self.callback = callback
        self.buttonText = buttonText
        self.accentColor = accentColor
        self.primaryColor = primaryColor
        self.backgroundColor = backgroundColor
        self.font = font
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
//
//struct TextViewer_Previews: PreviewProvider {
//    static var previews: some View {
//        // TODO
//    }
//}
