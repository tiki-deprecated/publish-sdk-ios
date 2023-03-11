import SwiftUI

public enum Sheets{
    case none,
         prompt,
         endingAccepted,
         endingDeclined,
         endingError
    
    func view(
        onLearnMore: (() -> Void)? = nil,
        onAccept: ((Offer) -> Void)? = nil,
        onDecline: ((Offer) -> Void)? = nil,
        requiredPermissions: [String]? = nil,
        onPermissionsGranted: ((Offer) -> Void)? = nil) -> AnyView
    {
        switch self {
        case .none :
            return AnyView(EmptyView())
        case .prompt :
            return AnyView(OfferPrompt(
                onAccept: onAccept!,
                onDecline: onDecline!,
                onLearnMore: onLearnMore!
            ))
        case .endingAccepted :
            return AnyView(
                Ending(
                    title: AnyView(YourChoince()),
                    message: "Awesome! You’re in",
                    footnote: AnyView(VStack{
                        Text("We’re on it, stay tuned.\nChange your mind anytime in settings.")
                    })
                ))
        case .endingDeclined :
            return AnyView(
                Ending(
                    title: AnyView(YourChoince()),
                    message: "Backing Off",
                    footnote: AnyView(VStack{Text("Your data is valuable.\nOpt-in anytime in settings.")})
                )
            )
        case .endingError :
            return AnyView(
                Ending(
                    title: AnyView(Whoops()),
                    message: "Permission Required",
                    footnote: AnyView(HStack{Text("Offer declined.")})
                )
            )
        }
    }
}
