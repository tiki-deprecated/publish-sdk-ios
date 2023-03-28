/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

struct Whoops: View{
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View{
        HStack(spacing: 0){
            Text("WHOOPS").font(.custom(TikiSdk.theme(colorScheme).fontBold, size: 20))
                .foregroundColor(Color(red:0.78, green: 0.18, blue: 0))
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}
