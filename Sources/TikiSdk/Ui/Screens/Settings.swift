/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI
import MarkdownUI

public struct Settings: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var accepted: Bool? = nil
    @State var showError: Bool = false
    @State var showLearnMore: Bool = false
    @State var pendingPermissions: [Permission]? = nil
    @State var offset: CGFloat = 0

    var onDismiss: (() -> Void)
    
    var title: AnyView = AnyView(TradeYourData())
    var onAccept: ((Offer?, LicenseRecord?) -> Void)? = nil
    var onDecline: ((Offer?, LicenseRecord?) -> Void)? = nil
    
    public init(
        offers: [String:Offer],
        onDismiss: @escaping (() -> Void),
        onAccept: ((Offer?, LicenseRecord?) -> Void)? = nil,
        onDecline: ((Offer?, LicenseRecord?) -> Void)? = nil
    ) {
        self.onDismiss = onDismiss
        self.onAccept = onAccept
        self.onDecline = onDecline
    }
    
    public var body: some View {
            ZStack{
                HStack(alignment: .top, spacing:0){
                    VStack(alignment: .center, spacing: 0) {
                        HStack(alignment: .center, spacing: 0){
                            Theme.backArrow.onTapGesture {
                                onDismiss()
                            }.padding(.trailing, 20)
                            title
                            Spacer()
                            LearnMoreButton(onTap: {
                                withAnimation(.easeOut){
                                    showLearnMore = true
                                }
                            })
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 30)
                        OfferCard(TikiSdk.instance.offers.values.first!)
                        UsedFor(bullets: TikiSdk.instance.offers.values.first!.bullets)
                        Text("TERMS & CONDITIONS")
                            .foregroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
                            .font(.custom(TikiSdk.theme(colorScheme).fontBold, size:16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 11)
                        ScrollView(.vertical) {
                            Markdown(MarkdownContent(TikiSdk.instance.offers.values.first!.terms!))
                                .markdownTextStyle(\.code) {
                                    ForegroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
                                    BackgroundColor(TikiSdk.theme(colorScheme).primaryBackgroundColor)
                                }
                                .padding(7)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(TikiSdk.theme(colorScheme).primaryBackgroundColor)
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
                                          {_decline(offer: TikiSdk.instance.offers.values.first!)},
                                          textColor: TikiSdk.theme(colorScheme).primaryTextColor,
                                          borderColor: TikiSdk.theme(colorScheme).accentColor,
                                          font: TikiSdk.theme(colorScheme).fontMedium
                            ).frame(maxWidth: .infinity).padding(.bottom, 16)
                        }else{
                            TikiSdkButton("Opt in",
                                          {_accept(offer: TikiSdk.instance.offers.values.first!)},
                                          textColor: TikiSdk.theme(colorScheme).primaryBackgroundColor,
                                          color: TikiSdk.theme(colorScheme).accentColor,
                                          font: TikiSdk.theme(colorScheme).fontMedium
                            ).frame(maxWidth: .infinity).padding(.bottom,16)
                        }
                    }
                }
                .padding(.horizontal, 15)
                if(showError){
                    EndingError(
                        pendingPermissions: $pendingPermissions,
                        onAuthorized: {
                            showError = false
                            _accept(offer: TikiSdk.instance.offers.values.first!)
                        }
                    ).asBottomSheet(
                        isShowing: $showError,
                        offset: $offset,
                        onDismiss: {
                            showError = false
                        }
                    )
                    .transition(.bottomSheet)
                }
                if(showLearnMore){
                    LearnMore()
                        .asNavigationRoute(
                            isShowing: $showLearnMore,
                            title: "LearnMore",
                            onDismiss: {
                                withAnimation(.easeOut){
                                    showLearnMore = false
                                }
                            }
                        )
                        .zIndex(1)
                        .transition(.navigate)
                }
            }
            .padding(safeAreaInsets)
            .background(TikiSdk.theme(colorScheme).secondaryBackgroundColor)
            .ignoresSafeArea()
            .onAppear{
                Task{
                    pendingPermissions = TikiSdk.instance.offers.values.first!.permissions
                    do{
                        accepted = try await self.guard()
                    }catch{
                        print(error)
                    }
                }
            }
    }
    
    func _decline(offer: Offer) {
        Task{
            do{
                let revokedOffer = Offer()
                    .id(offer.id)
                    .ptr(offer.ptr!)
                    .description(offer.description)
                revokedOffer.terms = offer.terms
                revokedOffer.reward = offer.reward
                revokedOffer.bullets = offer.bullets
                revokedOffer.tags = offer.tags
                revokedOffer.permissions = offer.permissions
                revokedOffer.expiry = offer.expiry
                revokedOffer.uses = []
                let _ = try await license(offer: revokedOffer)
                accepted = try await self.guard()
            }catch{
                print(error)
            }
        }
        onDecline?(offer, nil)
    }
    
    func _accept(offer: Offer) {
        if(pendingPermissions != nil && !pendingPermissions!.isEmpty){
            withAnimation(.easeOut){
                showError = true
            }
        }else{
            Task{
                do{
                    let _ = try await license(offer: offer)
                    accepted = try await self.guard()
                }catch{
                    print(error)
                }
                onAccept?(offer, nil)
            }
        }
    }
    
    func `guard`() async throws -> Bool{
        let ptr : String = TikiSdk.instance.offers.values.first!.ptr!
        var usecases: [Usecase] = []
        var destinations: [String] = []
        TikiSdk.instance.offers.values.first!.uses.forEach{ licenseUse in
            if(licenseUse.destinations != nil){
                destinations.append(contentsOf: licenseUse.destinations!)
            }
            usecases.append(contentsOf: licenseUse.usecases)
        }
        return try await TikiSdk.guard(ptr: ptr, usecases: usecases, destinations: destinations)
    }
    
    func license(offer: Offer) async throws -> LicenseRecord {
        return try await TikiSdk.license( offer.ptr!, offer.uses, String(offer.terms!), tags: offer.tags, licenseDescription: offer.description,expiry: offer.expiry)
    }
    
}
