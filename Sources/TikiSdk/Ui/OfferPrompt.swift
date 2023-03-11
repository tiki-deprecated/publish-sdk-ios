import SwiftUI

public struct OfferPrompt: View {

    @Environment(\.colorScheme) private var colorScheme
    
    var offers: [String:Offer]?
    var title: AnyView = AnyView(TradeYourData())
    var backgroundColor: Color? = nil
    var accentColor: Color? = nil
    var onAccept: ((Offer) -> Void)? = nil
    var onDecline: ((Offer) -> Void)? = nil
    var onLearnMore: (()->Void)? = nil
    
    public init(offers: [String:Offer]? = nil, title: AnyView? = nil, primaryBackgroundColor: Color? = nil, secondaryTextColor: Color? = nil, fontFamily: String? = nil, accentColor: Color? = nil, onAccept: ((Offer) -> Void)? = nil, onDecline: ((Offer) -> Void)? = nil, onLearnMore: @escaping (()->Void)) {
        self.offers = offers ?? TikiSdk.instance.offers
        self.title = title != nil ? title! : AnyView(TradeYourData())
        self.backgroundColor = primaryBackgroundColor
        self.accentColor = accentColor
        self.onAccept = onAccept
        self.onDecline = onDecline
        self.onLearnMore = onLearnMore
    }

    public var body: some View {
        if(offers?.values.first != nil){
            VStack(alignment: .center, spacing: 0) {
                ZStack {
                    title
                    HStack{
                        Spacer()
                        LearnMoreButton(onTap: self.onLearnMore)
                    }.padding(.trailing, 15)
                }.padding(.vertical, 32)
                OfferCard(offers!.values.first!)
                UsedFor(bullets: offers!.values.first!.usedBullet)
                HStack {
                    TikiSdkButton("Back Off",
                                  {_decline(offer: offers!.values.first!)},
                                  textColor: TikiSdk.instance.getActiveTheme(colorScheme).getSecondaryTextColor,
                                  borderColor: TikiSdk.instance.getActiveTheme(colorScheme).accentColor
                    ).frame(maxWidth: .infinity)
                    TikiSdkButton("I'm in", {_accept(offer: offers!.values.first!)}, color: TikiSdk.instance.getActiveTheme(colorScheme).accentColor ).frame(maxWidth: .infinity)
                }
                .padding(.bottom, 50)
            }
            .padding(.horizontal, 15)
            .background(backgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).getSecondaryBackgroundColor)
            .cornerRadius(40, corners: [.topLeft, .topRight])
        }
    }

    private func _decline(offer: Offer) {
        onDecline?(offer)
    }

    private func _accept(offer: Offer) {
        onAccept?(offer)
    }
}

struct TradeYourData: View{
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View{
        HStack{
            Text("TRADE").font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 20))
            Text(" YOUR ").font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 20)).foregroundColor(TikiSdk.instance.getActiveTheme(colorScheme).getAccentColor)
            Text("DATA").font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 20))
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 15)
    }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
