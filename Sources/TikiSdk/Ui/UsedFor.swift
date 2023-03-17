import SwiftUI

struct UsedFor: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let bullets: [UsedBullet]
    var primaryTextColor: Color? = nil
    var secondaryTextColor: Color? = nil
    var fontFamily: String? = nil

    init(bullets: [UsedBullet], primaryTextColor: Color? = nil, secondaryTextColor: Color? = nil, fontFamily: String? = nil ) {
        self.bullets = bullets
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColor = secondaryTextColor
        self.fontFamily = fontFamily
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("HOW YOUR DATA WILL BE USED")
                .foregroundColor(primaryTextColor ?? TikiSdk.theme(colorScheme).primaryTextColor)
                .font(.custom(fontFamily ?? TikiSdk.theme(colorScheme).fontBold, size: 16)).padding(.bottom, 16)
            ForEach(bullets, id: \.self) { item in
                HStack {
                    if item.isUsed {
                        Image("checkIcon")
                    } else {
                        Image("xIcon")
                    }
                    Text(item.text)
                        .foregroundColor(secondaryTextColor ?? TikiSdk.theme(colorScheme).secondaryTextColor)
                        .font(.custom(fontFamily ?? TikiSdk.theme(colorScheme).fontBold, size: 16))
                }.padding(.bottom, 16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
        .padding(.top, 24)
        .padding(.bottom, 16)
    }
}
