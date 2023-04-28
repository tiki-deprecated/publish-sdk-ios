/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

public struct NavigationHeader: View{
    
    @Environment(\.colorScheme) var colorScheme
    
    var title: String
    var onBackPressed: () -> Void
    
    public var body: some View {
        HStack(alignment: .center){
            Theme.backArrow.onTapGesture {
                onBackPressed()
            }.padding(.leading, 15).padding(.trailing, 20)
            Text(title).font(.custom(TikiSdk.theme(colorScheme).fontBold, size:20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
        }
        .frame(maxWidth: .infinity)
    }
}
