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
            }).padding(.bottom,40)
            ScrollView(.vertical) {
                Text(LocalizedStringKey(stringLiteral: offer!.terms!))
                .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:16))}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 0)
            Rectangle()
                .fill(TikiSdk.theme(colorScheme).accentColor)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
                .padding(.bottom, 30)
                .padding(.horizontal, 30)
            TikiSdkButton("I agree", {onAccept()}, color: TikiSdk.theme(colorScheme).accentColor).padding(16)
        }.navigationBarBackButtonHidden(true)
    }
}
