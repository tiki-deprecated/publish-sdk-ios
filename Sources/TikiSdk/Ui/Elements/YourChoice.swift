import SwiftUI

struct YourChoice: View{
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View{
        HStack(spacing: 0){
            Text("YOUR ")
                .font(.custom(TikiSdk.theme(colorScheme).fontBold, size:20))
                .foregroundColor(TikiSdk.theme(colorScheme).accentColor)
            Text("CHOICE")
                .font(.custom(TikiSdk.theme(colorScheme).fontBold, size: 20))
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
