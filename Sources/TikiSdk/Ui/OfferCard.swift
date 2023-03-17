import SwiftUI

struct OfferCard: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var offer: Offer? = nil
    var textColor: Color? = nil
    var backgroundColor: Color? = nil
    var fontFamily: String? = nil
    
    init(_ offer: Offer, textColor: Color? = nil, backgroundColor: Color? = nil, fontFamily: String? = nil) {
        self.offer = offer
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.fontFamily = fontFamily
    }
    
    var body: some View {
        VStack(alignment: .center,spacing: 0) {
            offer!.reward?
                .padding(.top, 20)
                .padding(.bottom, 12)
            Text(offer?.description ?? "")
                .padding(.bottom, 32)
                .font(
                    .custom(
                        TikiSdk.theme(colorScheme).fontBold,
                        size: 16))
                .foregroundColor(textColor  ?? TikiSdk.theme(colorScheme).secondaryTextColor)
                .lineLimit(3)
        }
        .padding(.horizontal, 20)
        .background(backgroundColor  ?? TikiSdk.theme(colorScheme).primaryBackgroundColor)
        .cornerRadius(10)
        .shadow(color: Color(red:0,green:0, blue:0).opacity(0.05), radius: 0, x:4, y:4)
    }
}
