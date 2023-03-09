import SwiftUI

struct OfferPrompt: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let offers: [Offer]
    let title: Text?
    let primaryBackgroundColor: Color?
    let secondaryTextColor: Color?
    let primaryTextColor: Color?
    let fontFamily: String?
    let accentColor: Color?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                title
                    .padding(.leading, 15)
                Spacer()
                LearnMoreButton(iconColor: secondaryTextColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getSecondaryTextColor)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)

            OfferCard(
                offers.first!,
                textColor: primaryTextColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor,
                backgroundColor: primaryBackgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryBackgroundColor,
                fontFamily: fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily
            )
            UsedFor(
                bullets: offers.first!.usedBullet,
                textColor: primaryTextColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor,
                fontFamily: fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily
            )
            HStack {
                TikiSdkButton("Back Off", {_accept(offer: offers.first!)},
                    textColor: primaryTextColor,
                    borderColor: accentColor,
                    fontFamily: fontFamily
                )
                TikiSdkButton(solid: "I'm in", {_accept(offer: offers.first!)},
                    color: accentColor,
                    fontFamily: fontFamily
                )
            }
            .padding(.bottom, 50)
            .padding(.horizontal, 15)
        }
        .background(
            primaryBackgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryBackgroundColor
        )
        .cornerRadius(40)
    }

    private func _decline(offer: Offer) {
        // handle declining the offer
    }

    private func _accept(offer: Offer) {
        // handle accepting the offer
    }
}
