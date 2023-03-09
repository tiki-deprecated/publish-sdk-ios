import SwiftUI

struct UsedFor: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let bullets: [UsedBullet]

    var textColor: Color? = nil
    var fontFamily: String? = nil

    init(bullets: [UsedBullet], textColor: Color? = nil, fontFamily: String? = nil ) {
        self.bullets = bullets
        self.textColor = textColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor
        self.fontFamily = fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("HOW YOUR DATA WILL BE USED")
                    .font(.system(size: 16, weight: .bold))
                    .lineSpacing(8)
                    .foregroundColor(textColor)
                    .font(.custom(fontFamily ?? "", size: 16))
                ForEach(bullets, id: \.self) { item in
                    HStack(alignment: .top, spacing: 10) {
                        if item.isUsed {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.red)
                        }
                        Text(item.text)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(textColor)
                            .font(.custom(fontFamily ?? "", size: 16))
                    }
                }
            }
            .padding(.horizontal, 30)
            Spacer()
        }
        .padding(.vertical, 20)
        .background(Color.white)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(color: Color.black.opacity(0.13), radius: 4, x: 4, y: 4))
    }
}
