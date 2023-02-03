/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct OwnershipView: View {
    
    var ownership: TikiSdkOwnership
    
    var body: some View {
        List{
            Section{
                Text("Ownership").fontWeight(.heavy)
                    .font(.largeTitle).padding()
                    .multilineTextAlignment(.leading).frame(maxWidth: .infinity)
            }
            .listRowInsets(EdgeInsets())
            .background(Color(.systemGroupedBackground))
            Section {
                VStack(alignment: .leading){
                    Text("Hash").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                    Text(ownership.transactionId)
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Source").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                    Text(ownership.source)
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Origin").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                    Text(ownership.origin)
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Contains").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                    Text(ownership.contains.joined(separator: ", "))
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("About").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                    Text(ownership.about ?? "")
                }
            }
        }.background(Color(.systemGray6))
    }
}

