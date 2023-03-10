import SwiftUI

public struct Ending: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    /// A `Text` title to be shown in the top of the bottom sheet.
    let title: Text
    
    /// The center message of the ending screen.
    let message: String
    
    /// The sub text shown below the message.
    let footnote: Text
    
    var primaryTextColor: Color?
    var backgroundColor: Color?
    var fontFamily: String?
    
    /// Ending Builder
    ///
    /// `TikiSdk.theme` is used for default styling.
    public init(title: Text, message: String, footnote: Text, primaryTextColor: Color? = nil, backgroundColor: Color? = nil, fontFamily: String? = nil) {
        self.title = title
        self.message = message
        self.footnote = footnote
        self.primaryTextColor = primaryTextColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor
        self.backgroundColor = backgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryBackgroundColor
        self.fontFamily = fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 36) {
            title.padding(.top, 28)
            Text(message)
                .font(.custom(fontFamily ?? "", size: 32))
                .fontWeight(.bold)
                .foregroundColor(primaryTextColor)
                .lineSpacing(42)
                .multilineTextAlignment(.center)
                .padding(.top, 36)
            footnote
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(40)
    }
}
