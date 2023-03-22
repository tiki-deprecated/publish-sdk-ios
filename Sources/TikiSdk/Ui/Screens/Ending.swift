import SwiftUI

public struct Ending: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    /// A `Text` title to be shown in the top of the bottom sheet.
    let title: AnyView
    
    /// The center message of the ending screen.
    let message: String
    
    /// The sub text shown below the message.
    let footnote: AnyView

    /// Ending Builder
    ///
    /// `TikiSdk.theme` is used for default styling.
    public init(title: AnyView, message: String, footnote: AnyView) {
        self.title = title
        self.message = message
        self.footnote = footnote
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0){
            title
                .padding(.top, 28)
            Text(message)
                .font(.custom(TikiSdk.theme(colorScheme).fontMedium, size: 32))
                .foregroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
                .padding(.vertical,36)
            footnote
                .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity)
        .background(TikiSdk.theme(colorScheme).primaryBackgroundColor)
    }
}
