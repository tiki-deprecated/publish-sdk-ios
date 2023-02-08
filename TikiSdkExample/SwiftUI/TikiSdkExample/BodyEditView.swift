/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct BodyEditView: View {
    
    @Binding var bodyData: String
    
    var body: some View {
        List{
            Section{
                Text("Body")
                    .font(.largeTitle).bold()
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading).listRowInsets(EdgeInsets()).padding(.bottom)
            }
            .listRowInsets(EdgeInsets())
            .background(Color(.systemGroupedBackground))
            Section{
                TextEditor(text: $bodyData)
                    .frame(height: 400, alignment: .leading)
                    .cornerRadius(10, antialiased: true)
                    .foregroundColor(.black)
                    .font(.body)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
        }.background(Color(UIColor.systemBackground))
    }
}

