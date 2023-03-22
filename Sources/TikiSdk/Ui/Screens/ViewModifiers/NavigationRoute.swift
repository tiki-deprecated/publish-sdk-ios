import SwiftUI

struct NavigationRoute: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Binding var isShowing: Bool
    
    var title: String
    var onDismiss: (() -> Void)
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            if (isShowing) {
                VStack{
                    NavigationHeader(title: title, onBackPressed: {
                        onDismiss()
                    })
                    content
                }
                .navigationBarBackButtonHidden(true)
                .padding(safeAreaInsets)
                .transition(.move(edge: .trailing))
                .background(
                    TikiSdk.theme(colorScheme).secondaryBackgroundColor
                )
                .offset(x: isShowing ? 0 : UIScreen.main.bounds.size.width, y: 0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

extension View {
    func asNavigationRoute(isShowing: Binding<Bool>, title: String, onDismiss: @escaping (() -> Void)) -> some View {
        modifier(NavigationRoute(isShowing: isShowing, title: title, onDismiss: onDismiss))
    }
}
