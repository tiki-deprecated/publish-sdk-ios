import SwiftUI

struct NavigationRoute: View {

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @Binding var isShowing: Bool
    var content: AnyView
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if (isShowing) {
                content
                    .padding(safeAreaInsets)
                    .transition(.move(edge: .trailing))
                    .background(
                       TikiSdk.instance.getActiveTheme(colorScheme).getPrimaryBackgroundColor
                    )
                    .offset(x: isShowing ? 0 : 500, y: 0)
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
