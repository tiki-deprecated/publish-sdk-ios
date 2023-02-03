/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct BodyEditView: View {
    
    @Binding var bodyData: String
    
    var body: some View {
        VStack{
            Text("Body")
            TextEditor(text: $bodyData)
                       .frame(height: 600, alignment: .leading)
                       .cornerRadius(10, antialiased: true)
                       .foregroundColor(.black)
                       .font(.body)
                       .padding()
                       .fixedSize(horizontal: false, vertical: true)
                       .multilineTextAlignment(.leading)
        }.background(Color(UIColor.systemBackground))
    }
}

