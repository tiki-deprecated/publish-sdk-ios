/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

/// A dismissible bottom sheet that will be shown after the TIKI flow is complete.
struct CompletionSheet: View {
    
    /// The color that will be used in "your".
    let accentColor: Color

    /// The text color.
    let primaryColor: Color

    /// The color used in all backgrounds.
    let backgroundColor: Color

    /// The main text in the center of the bottom sheet.
    let title: String

    /// The first line of text in the footer.
    ///
    /// This text will occupy just one line. An ellipsis will be added on overflow.
    let footerText: String

    /// The text to be shown before the "settings" link.
    let beforeLinkText: String

    /// The fontFamily from pubspec.
    let font: Font
    
    /// Default constructor for Completion Bottom Sheet
    ///
    /// - Parameters:
    ///   - title: the main text in the center of the bottom sheet
    ///   - footerText: the first line of text in the footer. One line of text.
    ///   - beforeLinkText: the text to be shown before the "settings" link.
    ///   - accentColor: The color that will be used in "your". Default #24956A
    ///   - primaryColor: The text color. Default #2D2D2D
    ///   - backgroundColor: default #FFFFFF
    ///   - font: The font to be used in the View. Default is `SpaceGrotesk` size 20.
    init(
        title : String,
        footerText: String,
        beforeLinkText: String,
        accentColor: Color = Color(hex: 0x0024956a),
        primaryColor: Color = Color(hex: 0x002D2D2D),
        backgroundColor: Color = Color(hex: 0x00ffffff),
        font: Font = Font.custom("SpaceGrotesk", size: 20)
      ){
          self.title = title
          self.footerText = footerText
          self.beforeLinkText = beforeLinkText
          self.accentColor = accentColor
          self.primaryColor = primaryColor
          self.backgroundColor = backgroundColor
          self.font = font
      }
    
    /// Description
    /// - Parameters:
    ///   - accentColor: The color that will be used in "your". Default #24956A
    ///   - primaryColor: The text color. Default #2D2D2D
    ///   - backgroundColor: default #FFFFFF
    ///   - font: The font to be used in the View. Default is `SpaceGrotesk` size 20.
    /// - Returns: Awesome CompletionSheet
    static func awesome(
        accentColor: Color = Color(hex: 0x0024956a),
        primaryColor: Color = Color(hex: 0x002D2D2D),
        backgroundColor: Color = Color(hex: 0x00ffffff),
        font: Font = Font.custom("SpaceGrotesk", size: 20)
      ) -> CompletionSheet{
          return CompletionSheet(
            title: "Awesome! You’re in",
            footerText: "We’re on it, stay tuned.",
            beforeLinkText: "Change your mind anytime in",
            accentColor: accentColor,
            primaryColor: primaryColor,
            backgroundColor: backgroundColor
          )
      }
    
    /// The CompletionSheet to be shown after user denies the use of data.
    /// - Parameters:
    ///   - accentColor: The color that will be used in "your". Default #24956A
    ///   - primaryColor: The text color. Default #2D2D2D
    ///   - backgroundColor: default #FFFFFF
    ///   - font: The font to be used in the View. Default is `SpaceGrotesk` size 20.
    /// - Returns: Back Off Completion Sheet
    static func backoff(
        accentColor: Color = Color(hex: 0x0024956a),
        primaryColor: Color = Color(hex: 0x002D2D2D),
        backgroundColor: Color = Color(hex: 0x00ffffff),
        font: Font = Font.custom("SpaceGrotesk", size: 20)
    ) -> CompletionSheet{
        return CompletionSheet(
            title: "Backing Off",
            footerText: "Your data is valuable.",
            beforeLinkText: "Opt-in anytime in",
            accentColor: accentColor,
            primaryColor: primaryColor,
            backgroundColor: backgroundColor
        )
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
}

//struct CompletionSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        // TODO
//    }
//}
