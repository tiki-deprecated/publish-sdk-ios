import SwiftUI

public struct Terms : View{
    
    @Environment(\.colorScheme) var colorScheme
    var offer: Offer?
    var onDismiss: (() -> Void)
    var onAccept: (() -> Void)
    
    public var body: some View {
        VStack(spacing:0){
            NavigationHeader(title: "Terms and Conditions", onBackPressed: {
                onDismiss()
            }).padding(.bottom,15)
            ScrollView(.vertical) {Text(offer?.terms ?? "")
                .font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size:16))}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 30)
                    .padding(.top, 25)
                    .padding(.bottom, 0)
            Rectangle()
                .fill(TikiSdk.instance.getActiveTheme(colorScheme).accentColor)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
                .padding(.bottom, 20)
                .padding(.horizontal, 30)
            TikiSdkButton("I agree", {onAccept()}, color: TikiSdk.instance.getActiveTheme(colorScheme).getAccentColor).padding(16)
        }.navigationBarBackButtonHidden(true)
    }
}
