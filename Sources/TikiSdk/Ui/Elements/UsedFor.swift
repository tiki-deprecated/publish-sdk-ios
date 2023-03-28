/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

struct UsedFor: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let bullets: [Bullet]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("HOW YOUR DATA WILL BE USED")
                .foregroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
                .font(.custom(TikiSdk.theme(colorScheme).fontBold, size: 16)).padding(.bottom, 16)
            ForEach(bullets, id: \.self) { item in
                HStack {
                    if item.isUsed {
                        Theme.checkIcon
                    } else {
                        Theme.xIcon
                    }
                    Text(item.text)
                        .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                        .font(.custom(TikiSdk.theme(colorScheme).fontBold, size: 16))
                }.padding(.bottom, 16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
        .padding(.top, 24)
        .padding(.bottom, 16)
    }
}
