import SwiftUI

struct BottomSheet: View {

    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isShowing: Bool
    @Binding var offset: CGFloat
    var dismiss: (() -> Void)
    var content: AnyView
    
    
    var body: some View {
        if (isShowing) {
            ZStack{
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                        dismiss()
                    }
                content
                    .transition(.move(edge: .bottom))
                    .background(
                        TikiSdk.instance.getActiveTheme(colorScheme).getPrimaryBackgroundColor
                    )
                    .cornerRadius(40, corners: [.topLeft, .topRight])
                    .offset(x: 0, y: offset)
                    .background(Color(.clear))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
                    .animation(.easeInOut, value: isShowing)
            }
        }
    }
}
