import SwiftUI

struct LearnMoreButton: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var iconColor: Color?
    var textColor: Color?
    var backgroundColor: Color?
    var fontFamily: String?
    var fontPackage: String?
    
    init(iconColor: Color? = nil, textColor: Color? = nil, backgroundColor: Color? = nil, fontFamily: String? = nil, fontPackage: String? = nil) {
        self.iconColor = iconColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getSecondaryTextColor
        self.textColor = textColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor
        self.backgroundColor = backgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryBackgroundColor
        self.fontFamily = fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily
    }
    
    var body: some View {
        Button(action: {
            // handle button tap
        }) {
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)
        }
        .buttonStyle(PlainButtonStyle())
        .background(backgroundColor)
    }
}
