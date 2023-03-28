/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

struct OfferCard: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var offer: Offer? = nil
    
    init(_ offer: Offer) {
        self.offer = offer
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
                .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 20)
        .background(TikiSdk.theme(colorScheme).primaryBackgroundColor)
        .cornerRadius(10)
        .shadow(color: Color(red:0,green:0, blue:0).opacity(0.05), radius: 0, x:4, y:4)
    }
}
