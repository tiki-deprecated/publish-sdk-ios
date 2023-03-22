import SwiftUI

struct LearnMoreButton: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var onTap: (() -> Void)?
    
    init(iconColor: Color? = nil, onTap: (() -> Void)? = nil) {
        self.onTap = onTap
    }
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            Image("questionIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                .frame(width: 24, height: 24)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
