/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI
import MarkdownUI

public struct LearnMore : View{
    
    @Environment(\.colorScheme) var colorScheme
    
    var learnMoreText: String = try! String(
        contentsOfFile: Bundle.module.path(forResource: "learnMore", ofType: "md")!,
        encoding: String.Encoding(rawValue: NSUTF8StringEncoding))
    
    public var body: some View {
        return ScrollView(.vertical){
            Markdown(MarkdownContent(learnMoreText)).markdownTextStyle(\.code) {
                ForegroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
                BackgroundColor(TikiSdk.theme(colorScheme).primaryBackgroundColor)
              }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .padding(.top, 25)
        .padding(.bottom, 0)
    }
}
