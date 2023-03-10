import SwiftUI

public struct OfferPrompt: View {

    @Environment(\.colorScheme) private var colorScheme
    
    var offers: [String:Offer] = [:]
    var title: AnyView = AnyView(TradeYourData())
    var backgroundColor: Color? = nil
    var secondaryTextColor: Color? = nil
    var primaryTextColor: Color? = nil
    var fontFamily: String? = nil
    var accentColor: Color? = nil
    
    init(offers: [String:Offer], title: AnyView? = nil, primaryBackgroundColor: Color? = nil, secondaryTextColor: Color? = nil, primaryTextColor: Color? = nil, fontFamily: String? = nil, accentColor: Color? = nil) {
        self.offers = offers
        self.title = title != nil ? title! : AnyView(TradeYourData())
        self.backgroundColor = primaryBackgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getSecondaryBackgroundColor
        self.secondaryTextColor = secondaryTextColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getSecondaryTextColor
        self.primaryTextColor = primaryTextColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getPrimaryTextColor
        self.fontFamily = fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily

        self.accentColor = accentColor
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                title
                HStack{
                    Spacer()
                    LearnMoreButton(iconColor: secondaryTextColor)
                }
            }.padding(.vertical, 20)
            OfferCard(offers.values.first!)
            UsedFor(bullets: offers.values.first!.usedBullet)
            HStack {
                TikiSdkButton("Back Off", {_accept(offer: offers.values.first!)}, borderColor: TikiSdk.instance.getActiveTheme(colorScheme).accentColor).frame(maxWidth: .infinity)
                TikiSdkButton("I'm in", {_accept(offer: offers.values.first!)}, color: TikiSdk.instance.getActiveTheme(colorScheme).accentColor ).frame(maxWidth: .infinity)
            }
            .padding(.bottom, 50)
        }.padding(.horizontal, 15)
        .background(
            backgroundColor
        )
    }

    private func _decline(offer: Offer) {
        // handle declining the offer
    }

    private func _accept(offer: Offer) {
        // handle accepting the offer
    }
}

struct TradeYourData: View{
    var body: some View{
        Text("Trade your data")
    }
}
