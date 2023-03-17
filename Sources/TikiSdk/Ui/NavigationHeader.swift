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
            Text(title).font(.custom(TikiSdk.theme(colorScheme).fontBold, size:20))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
    }
}
