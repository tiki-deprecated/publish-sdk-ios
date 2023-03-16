import SwiftUI

public enum Sheets{
    case none,
         prompt,
         endingAccepted,
         endingDeclined,
         endingError
    
    func view(
        _ colorScheme: ColorScheme,
        onLearnMore: (() -> Void)? = nil,
        onAccept: ((Offer?, LicenseRecord?) -> Void)? = nil,
        onDecline: ((Offer?, LicenseRecord?) -> Void)? = nil,
        requiredPermissions: [PermissionType]? = nil,
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
                    footnote: AnyView(
                        VStack{
                            Text("Your data is valuable.")
                                .font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 18))
                            //.fontWeight(.light)
                                .foregroundColor(Color(.black).opacity(0.6))
                                .padding(.bottom, 1)
                            HStack{
                                Text("Opt-in anytime in")
                                    .font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 18))
                                    .foregroundColor(Color(.black).opacity(0.6))
                                Text("settings.")
                                    .underline()
                                    .font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 18)
                                    ).fontWeight(.ultraLight)
                                    .foregroundColor(Color(.black).opacity(0.6))
                            }
                        }
                    )))
        case .endingError :
            return AnyView(
                Ending(
                    title: AnyView(Whoops()),
                    message: "Permission Required",
                    footnote: AnyView(
                        VStack{
                            Text("Offer declined.")
                                .font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 18))
                                .foregroundColor(Color(.black).opacity(0.6))
                            HStack{
                                Text("To proceed, allow")
                                    .font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 18))
                                    .foregroundColor(Color(.black).opacity(0.6))
                                Text("permissions.").font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 18))
                                    .font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 18))
                                    .foregroundColor(Color(.black).opacity(0.6))
                                    .underline()
                                    .onTapGesture {
                                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                            return
                                        }
                                        if UIApplication.shared.canOpenURL(settingsUrl) {
                                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                                        }
                                        
                                    }
                            }
                        }
                    )
                )
            )
        }
    }
}
