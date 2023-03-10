import SwiftUI

struct OfferCard: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var offer: Offer? = nil
    var textColor: Color? = nil
    var backgroundColor: Color? = nil
    var fontFamily: String? = nil
    
    init(_ offer: Offer, textColor: Color? = nil, backgroundColor: Color? = nil, fontFamily: String? = nil) {
        self.offer = offer
        self.textColor = textColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getPrimaryTextColor
        self.backgroundColor = backgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getPrimaryBackgroundColor
        self.fontFamily = fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily
    }
    
    var body: some View {
        VStack(alignment: .center) {
            offer!.reward
            Text(offer?.description ?? "")
                .font(fontFamily != nil ? .custom(fontFamily!, size: 16) : .system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .lineLimit(3)
        }
        .padding([.top, .horizontal], 20)
        .padding(.bottom, 35)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(color: Color(red:0,green:0, blue:0).opacity(0.05), radius: 0, x:4, y:4)
    }
}
