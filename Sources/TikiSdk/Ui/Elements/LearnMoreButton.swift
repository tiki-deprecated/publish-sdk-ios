import SwiftUI

struct LearnMoreButton: View {
    
    @State private var debounceWorkItem: DispatchWorkItem?
    @Environment(\.colorScheme) private var colorScheme
    
    var onTap: (() -> Void)?
    
    init(iconColor: Color? = nil, onTap: (() -> Void)? = nil) {
        self.onTap = onTap
    }
    
    var body: some View {
        Button(action: {
            self.debounceWorkItem?.cancel()
            self.debounceWorkItem = DispatchWorkItem {
                onTap?()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: self.debounceWorkItem!)
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
