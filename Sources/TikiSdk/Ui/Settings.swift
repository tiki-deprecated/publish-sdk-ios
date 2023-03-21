import SwiftUI

public struct Settings: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State var accepted: Bool? = nil
    
    var offers: [String:Offer]?
    var title: AnyView = AnyView(TradeYourData())
    var backgroundColor: Color? = nil
    var accentColor: Color? = nil
    var onAccept: ((Offer?, LicenseRecord?) -> Void)? = nil
    var onDecline: ((Offer?, LicenseRecord?) -> Void)? = nil
    var onDismiss: (() -> Void)
    
    public init(onDismiss: @escaping (() -> Void), offers: [String:Offer]? = nil, title: AnyView? = nil, primaryBackgroundColor: Color? = nil, secondaryTextColor: Color? = nil, fontFamily: String? = nil, accentColor: Color? = nil, onAccept: ((Offer?, LicenseRecord?) -> Void)? = nil, onDecline: ((Offer?, LicenseRecord?) -> Void)? = nil) {
        self.onDismiss = onDismiss
        self.offers = offers ?? TikiSdk.instance.offers
        self.title = title != nil ? title! : AnyView(TradeYourData())
        self.backgroundColor = primaryBackgroundColor
        self.accentColor = accentColor
        self.onAccept = onAccept
        self.onDecline = onDecline
    }
    
    public var body: some View {
        if(offers?.values.first != nil){
            HStack(alignment: .top, spacing:0){
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 0){
                        Image("backArrow").onTapGesture {
                            onDismiss()
                        }.padding(.trailing, 20)
                        title
                        Spacer()
                        LearnMoreButton(onTap: { })
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 30)
                    OfferCard(offers!.values.first!)
                    UsedFor(bullets: offers!.values.first!.usedBullet)
                    Text("TERMS & CONDITIONS")
                        .font(.custom(TikiSdk.theme(colorScheme).fontBold, size:16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 11)
                    ScrollView(.vertical) {
                        Text(LocalizedStringKey(stringLiteral: offers!.values.first!.terms))
                            .padding(7)
                        .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:12))}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.white))
                    .padding(.horizontal, 15)
                    .padding(.bottom, 0)
                    Rectangle()
                        .fill(TikiSdk.theme(colorScheme).accentColor)
                        .frame(height: 1)
                        .edgesIgnoringSafeArea(.horizontal)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 15)
                    if(accepted == nil){
                        ProgressView()
                    }else if(accepted!){
                        TikiSdkButton("Opt out",
                                      {_decline(offer: offers!.values.first!)},
                                      textColor: TikiSdk.theme(colorScheme).primaryTextColor,
                                      borderColor: TikiSdk.theme(colorScheme).accentColor,
                                      font: TikiSdk.theme(colorScheme).fontMedium
                        ).frame(maxWidth: .infinity).padding(.bottom, 16)
                    }else{
                        TikiSdkButton("Opt in",
                                      {_accept(offer: offers!.values.first!)},
                                      color: TikiSdk.theme(colorScheme).accentColor,
                                      font: TikiSdk.theme(colorScheme).fontMedium
                        ).frame(maxWidth: .infinity).padding(.bottom,16)
                    }
                }
            }
            .padding(.horizontal, 15)
            .background(backgroundColor ?? TikiSdk.theme(colorScheme).secondaryBackgroundColor)
            .onAppear{
                Task{
                    do{
                        accepted = try await TikiSdk.guardOffer(TikiSdk.instance.offers.values.first!)
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    private func _decline(offer: Offer) {
        onDecline?(offer, nil)
    }
    
    private func _accept(offer: Offer) {
        onAccept?(offer, nil)
    }
}
