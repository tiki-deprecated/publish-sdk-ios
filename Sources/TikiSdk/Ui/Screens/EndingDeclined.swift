/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

struct EndingDeclined: View{
    
    @Environment(\.colorScheme) private var colorScheme
    var onSettings: (() -> Void)
    var dismiss: (() -> Void)
    
    var body: some View {
        Ending(
            title: AnyView(YourChoice()),
            message: "Backing Off",
            footnote: AnyView(
                VStack(spacing: 0){
                    Text("Your data is valuable.")
                        .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                        .fontWeight(.light)
                        .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                        .padding(.bottom, 6)
                    HStack(spacing: 0){
                        Text("Opt-in anytime in ")
                            .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                            .fontWeight(.light)
                            .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                        Text("settings.")
                            .font(.custom(TikiSdk.theme(colorScheme).fontRegular, size:18))
                            .fontWeight(.light)
                            .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                            .underline()
                            .fontWeight(.ultraLight)
                            .foregroundColor(TikiSdk.theme(colorScheme).secondaryTextColor)
                            .onTapGesture {
                                dismiss()
                                onSettings()
                            }
                    }
                }
            ))
    }
    
}
