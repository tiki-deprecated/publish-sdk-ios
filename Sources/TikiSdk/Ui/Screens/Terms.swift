/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI
import MarkdownUI

public struct Terms : View{
    
    @Environment(\.colorScheme) var colorScheme
    var onAccept: (() -> Void)
    var terms: String
    
    public var body: some View {
        VStack(spacing:0){
            ScrollView(.vertical) {
                Markdown(MarkdownContent(terms))
                    .markdownTextStyle(\.code) {
                      ForegroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
                      BackgroundColor(TikiSdk.theme(colorScheme).primaryBackgroundColor)
                    }
            }
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
            TikiSdkButton("I agree", onAccept, textColor: TikiSdk.theme(colorScheme).primaryBackgroundColor, color: TikiSdk.theme(colorScheme).accentColor).padding(16)
        }
    }
}
