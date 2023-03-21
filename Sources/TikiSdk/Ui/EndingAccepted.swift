import SwiftUI

struct EndingAccepted: View{
    
    @Environment(\.colorScheme) private var colorScheme
    var onSettings: (() -> Void)
    var dismiss: (() -> Void)
    
    var body: some View {
        Ending(
            title: AnyView(YourChoice()),
            message: "Awesome! You’re in",
            footnote: AnyView(VStack(spacing: 0){
                Text("We’re on it, stay tuned.").font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                    .fontWeight(.light)
                    .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                    .padding(.bottom, 6)
                HStack(spacing: 0){
                    Text("Change your mind anytime in ").font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                        .fontWeight(.light)
                        .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                    Text("settings.").font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                        .fontWeight(.light)
                        .underline()
                        .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                        .onTapGesture{
                            dismiss()
                            onSettings()
                        }
                }

            }))
    }
}
