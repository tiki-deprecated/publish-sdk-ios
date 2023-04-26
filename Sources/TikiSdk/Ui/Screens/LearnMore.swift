/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

public struct LearnMore : View{
    
    @Environment(\.colorScheme) var colorScheme
    
    var learnMoreText: AttributedString = try! AttributedString(markdown: String(
        contentsOfFile: Bundle.module.path(forResource: "learnMore", ofType: "md")!,
        encoding: String.Encoding(rawValue: NSUTF8StringEncoding)))
    
    public var body: some View {
        return ScrollView(.vertical){
            Text(learnMoreText)
                .foregroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
        .padding(.top, 25)
        .padding(.bottom, 0)
    }
}
