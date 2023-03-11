import SwiftUI

public enum Routes{
    case none,
         terms,
         learnMore,
         settings
    
    func view(
        offer: Offer? = nil,
        onLearnMore: (() -> Void)? = nil,
        onAccept: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        requiredPermissions: [String]? = nil,
        onPermissionsGranted: ((Offer) -> Void)? = nil) -> AnyView
    {
        switch self {
        case .none :
            return AnyView(EmptyView())
        case .terms :
            return AnyView(
                Terms(offer: offer, onDismiss: onDismiss!, onAccept: onAccept!))
        case .learnMore:
            return AnyView(
                LearnMore(onDismiss: onDismiss!)
            )
        case .settings:
            return AnyView(
                EmptyView() // TODO
            )
        }
    }
}
