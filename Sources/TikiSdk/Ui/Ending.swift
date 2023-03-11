import SwiftUI

public struct Ending: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    /// A `Text` title to be shown in the top of the bottom sheet.
    let title: AnyView
    
    /// The center message of the ending screen.
    let message: String
    
    /// The sub text shown below the message.
    let footnote: AnyView
    
    var primaryTextColor: Color?
    var backgroundColor: Color?
    var fontFamily: String?
    
    /// Ending Builder
    ///
    /// `TikiSdk.theme` is used for default styling.
    public init(title: AnyView, message: String, footnote: AnyView, primaryTextColor: Color? = nil, backgroundColor: Color? = nil, fontFamily: String? = nil) {
        self.title = title
        self.message = message
        self.footnote = footnote
        self.primaryTextColor = primaryTextColor
        self.backgroundColor = backgroundColor
        self.fontFamily = fontFamily
    }
    
    public var body: some View {
        VStack{
            title.padding(.top, 28)
            Text(message)
                .font(.custom(fontFamily ?? TikiSdk.instance.getActiveTheme(colorScheme).fontFamily, size: 32))
                .fontWeight(.bold)
                .foregroundColor(primaryTextColor  ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryTextColor)
                .lineSpacing(42)
                .multilineTextAlignment(.center)
                .padding(.top, 36)
            footnote
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(backgroundColor ?? TikiSdk.instance.getActiveTheme(colorScheme).primaryBackgroundColor)
        .cornerRadius(40, corners: [.topRight,.topLeft])
    }
}

struct YourChoince: View{
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View{
        HStack{
            Text("YOUR ").font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 20)).foregroundColor(TikiSdk.instance.getActiveTheme(colorScheme).getAccentColor)
            Text("CHOICE").font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 20))
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 15)
    }
}

struct Whoops: View{
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View{
        HStack{
            Text("WHOOOPS").font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size: 20)).foregroundColor(Color(red:0.78, green: 0.18, blue: 0))
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 15)
    }
}
