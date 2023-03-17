import SwiftUI

public enum Sheets{
    case none,
         prompt,
         endingAccepted,
         endingDeclined,
         endingError
    
    func view(
        _ colorScheme: ColorScheme,
        offer: Offer? = nil,
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
                    title: AnyView(YourChoice()),
                    message: "Awesome! You’re in",
                    footnote: AnyView(VStack(spacing: 0){
                        Text("We’re on it, stay tuned.").font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                            .fontWeight(.light)
                            .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                            .padding(.bottom, 6)
                        Text("Change your mind anytime in settings.").font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                            .fontWeight(.light)
                            .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                    })
                ))
        case .endingDeclined :
            return AnyView(
                Ending(
                    title: AnyView(YourChoice()),
                    message: "Backing Off",
                    footnote: AnyView(
                        VStack(spacing: 0){
                            Text("Your data is valuable.")
                                .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                                .fontWeight(.light)
                                .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                                .padding(.bottom, 6)
                            HStack(spacing: 0){
                                Text("Opt-in anytime in ")
                                    .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                                    .fontWeight(.light)
                                    .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                                Text("settings.")
                                    .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                                    .fontWeight(.light)
                                    .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                                    .underline()
                                    .fontWeight(.ultraLight)
                                    .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                                    .onTapGesture {
                                        TikiSdk.settings()
                                    }
                            }
                        }
                    )))
        case .endingError :
            return AnyView(
                Ending(
                    title: AnyView(Whoops()),
                    message: "Permission Required",
                    footnote: AnyView(
                        VStack(spacing:0){
                            Text("Offer declined.")
                                .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
                                .foregroundColor(Color(.black).opacity(0.6))
                            HStack(spacing:0){
                                Text("To proceed, allow ")
                                    .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
                                    .foregroundColor(Color(.black).opacity(0.6))
                                Text((requiredPermissions?[0].name())  ??  "permissions.").font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
                                    .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size: 18))
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
