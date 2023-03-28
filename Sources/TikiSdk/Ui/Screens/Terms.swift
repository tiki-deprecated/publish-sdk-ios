/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

public struct Terms : View{
    
    @Environment(\.colorScheme) var colorScheme
    var onAccept: (() -> Void)
    var terms: String
    
    public var body: some View {
        VStack(spacing:0){
            ScrollView(.vertical) {
                Text(LocalizedStringKey(stringLiteral: terms))
                .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:16))}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                    .padding(.bottom, 0)
            Rectangle()
                .fill(TikiSdk.theme(colorScheme).accentColor)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
                .padding(.bottom, 30)
                .padding(.horizontal, 30)
            TikiSdkButton("I agree", onAccept, color: TikiSdk.theme(colorScheme).accentColor).padding(16)
        }
    }
}
