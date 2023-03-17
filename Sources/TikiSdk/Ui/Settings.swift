import SwiftUI

public struct Settings : View{
    
    @Environment(\.colorScheme) var colorScheme
    var onAccept: ((Offer) -> Void)
    var onDecline: ((Offer) -> Void)
    var onLearnMore: (() -> Void)
    var onDismiss: (() -> Void)
    public var body: some View {
        Text("Terms")
    }
}

