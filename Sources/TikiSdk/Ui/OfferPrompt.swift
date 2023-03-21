import SwiftUI

public struct OfferPrompt: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var currentOffer: Offer
    
    var offers: [String:Offer]
    var title: AnyView = AnyView(TradeYourData())
    var backgroundColor: Color? = nil
    var accentColor: Color? = nil
    var onAccept: ((Offer) -> Void)
    var onDecline: ((Offer) -> Void)
    var onLearnMore: (()->Void)
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                title.padding(.leading, 15)
                HStack{
                    Spacer()
                    LearnMoreButton(onTap: self.onLearnMore)
                }.padding(.trailing, 15)
            }.padding(.vertical, 32)
            OfferCard(currentOffer)
            UsedFor(bullets: currentOffer.usedBullet)
            HStack {
                TikiSdkButton("Back Off", {onDecline(currentOffer)},
                              textColor: TikiSdk.theme(colorScheme).primaryTextColor,
                              borderColor: TikiSdk.theme(colorScheme).accentColor,
                              font: TikiSdk.theme(colorScheme).fontMedium
                ).frame(maxWidth: .infinity).padding(.trailing, 12)
                TikiSdkButton("I'm in", {onAccept(currentOffer)},
                              color: TikiSdk.theme(colorScheme).accentColor,
                              font: TikiSdk.theme(colorScheme).fontMedium
                ).frame(maxWidth: .infinity).padding(.leading, 12)
            }
            .padding(.bottom, 50)
        }
        .padding(.horizontal, 15)
        .background(backgroundColor ?? TikiSdk.theme(colorScheme).secondaryBackgroundColor)
    }
}
