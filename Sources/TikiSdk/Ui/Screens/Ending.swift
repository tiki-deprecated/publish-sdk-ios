/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

public struct Ending: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let title: AnyView
    let message: String
    let footnote: AnyView

    public init(title: AnyView, message: String, footnote: AnyView) {
        self.title = title
        self.message = message
        self.footnote = footnote
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0){
            title
                .padding(.top, 28)
            Text(message)
                .font(.custom(TikiSdk.theme(colorScheme).fontMedium, size: 32))
                .foregroundColor(TikiSdk.theme(colorScheme).primaryTextColor)
                .padding(.vertical,36)
            footnote
                .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity)
        .background(TikiSdk.theme(colorScheme).primaryBackgroundColor)
    }
}
