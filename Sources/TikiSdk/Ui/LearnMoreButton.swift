import SwiftUI

struct LearnMoreButton: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var iconColor: Color?
    var onTap: (() -> Void)?
    
    init(iconColor: Color? = nil, onTap: (() -> Void)? = nil) {
        self.onTap = onTap
        self.iconColor = iconColor
    }
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            Image("questionIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(iconColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getSecondaryTextColor)
                .frame(width: 24, height: 24)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
