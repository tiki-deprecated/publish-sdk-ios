import SwiftUI

struct OfferCard: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var offer: Offer? = nil
    var textColor: Color? = nil
    var backgroundColor: Color? = nil
    var fontFamily: String? = nil
    
    init(_ offer: Offer, textColor: Color? = nil, backgroundColor: Color? = nil, fontFamily: String? = nil) {
        self.offer = offer
        self.textColor = textColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor
        self.backgroundColor = backgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryBackgroundColor
        self.fontFamily = fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily
    }
    
    var body: some View {
        let maxWidth = UIScreen.main.bounds.width - 30
        
        VStack(alignment: .leading, spacing: 15) {
            offer!.reward
                .frame(width: min(maxWidth, 300), height: 86)
            
            Text(offer?.description ?? "")
                .font(fontFamily != nil ? .custom(fontFamily!, size: 16) : .system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .lineLimit(3)
                .frame(maxWidth: maxWidth, alignment: .leading)
        }
        .padding(20)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 4, y: 4)
    }
}
