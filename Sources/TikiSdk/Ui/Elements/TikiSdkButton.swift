/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import SwiftUI

public struct TikiSdkButton: View {
    
    @State private var debounceWorkItem: DispatchWorkItem?
    @Environment(\.colorScheme) private var colorScheme
    
    let text: String
    let onTap: () -> Void
    var backgroundColor: Color?
    var borderColor: Color?
    var textColor: Color?
    var font: String?
    
    public init(_ text: String, _ onTap: @escaping () -> Void,
         textColor: Color,
         borderColor: Color,
         font: String? = nil) {
        self.text = text
        self.onTap = onTap
        self.textColor = textColor
        self.borderColor = borderColor
        self.font = font
        self.backgroundColor = TikiSdk.theme(colorScheme).primaryBackgroundColor
    }
    
    public init(_ text: String, _ onTap: @escaping () -> Void,
         color: Color,
         font: String? = nil) {
        self.text = text
        self.onTap = onTap
        self.textColor = TikiSdk.theme(colorScheme).primaryBackgroundColor
        self.backgroundColor = color
        self.borderColor = color
        self.font = font
    }
    
    public var body: some View {
        
        VStack{
            Text(text)
                .font(.custom(font ?? TikiSdk.theme(colorScheme).fontMedium, size: 20))
                .lineSpacing(1.2)
                .foregroundColor(textColor ?? TikiSdk.theme(colorScheme).primaryTextColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 14)
        .background(backgroundColor)
        .cornerRadius(10)
        .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor!, lineWidth: 1)
                )
        .onTapGesture() {
            self.debounceWorkItem?.cancel()
            self.debounceWorkItem = DispatchWorkItem {
                onTap()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: self.debounceWorkItem!)
        }
    }
}
