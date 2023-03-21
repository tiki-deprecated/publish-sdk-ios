import SwiftUI

struct BottomSheet: ViewModifier {

    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isShowing: Bool
    @Binding var offset: CGFloat
    var onDismiss: (() -> Void)?
    
    func body(content: Content) -> some View {
        ZStack{
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss?()
                }
            content
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
                .offset(y: offset)
        }
    }
}

extension View {
    func asBottomSheet(isShowing: Binding<Bool>, offset: Binding<CGFloat>, onDismiss: @escaping (() -> Void)) -> some View {
        modifier(BottomSheet(isShowing: isShowing, offset: offset, onDismiss: onDismiss))
    }
}



