import SwiftUI

public struct NavigationHeader: View{
    
    @Environment(\.colorScheme) var colorScheme
    
    var title: String
    var onBackPressed: () -> Void
    
    public var body: some View {
        HStack(alignment: .center){
            Image("backArrow").onTapGesture {
                onBackPressed()
            }.padding(.leading, 15).padding(.trailing, 20)
            Text(title).font(.custom(TikiSdk.instance.getActiveTheme(colorScheme).getFontFamily, size:20)).fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
    }
}
