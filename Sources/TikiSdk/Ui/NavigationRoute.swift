import SwiftUI

struct NavigationRoute: View {

    @Environment(\.colorScheme) var colorScheme
    @Binding var isShowing: Bool
    var content: AnyView
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if (isShowing) {
                content
                    .transition(.move(edge: .trailing))
                    .background(
                       TikiSdk.instance.getActiveTheme(colorScheme).getPrimaryBackgroundColor
                    )
                    .offset(x: isShowing ? 0 : 500, y: 0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .animation(.easeInOut, value: isShowing)
    }
}
