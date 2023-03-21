import SwiftUI

struct TradeYourData: View{
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View{
        
        HStack{
            Text("TRADE").font(.custom("SpaceGrotesk-Bold", size: 20))
            Text("YOUR").font(.custom("SpaceGrotesk-Bold", size: 20)).foregroundColor(TikiSdk.theme(colorScheme).accentColor)
            Text("DATA").font(.custom("SpaceGrotesk-Bold", size: 20))
        }.frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
