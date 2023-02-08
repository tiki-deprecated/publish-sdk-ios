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
                Text("Ownership")
                    .font(.largeTitle).bold()
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading).listRowInsets(EdgeInsets())
            }
            .listRowInsets(EdgeInsets())
            .background(Color(.systemGroupedBackground))
            Section {
                VStack(alignment: .leading){
                    Text("Hash").font(.system(size: 14)).foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden).padding(.bottom)
                    Text(ownership.transactionId)
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Source").foregroundColor(.blue).font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden).padding(.bottom)
                    Text(ownership.source).font(.system(size: 14))
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Origin").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden).font(.system(size: 14)).padding(.bottom)
                    Text(ownership.origin).font(.system(size: 14))
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Contains").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden).font(.system(size: 14)).padding(.bottom)
                    Text(ownership.contains.joined(separator: ", ")).font(.system(size: 14))
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("About").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden).font(.system(size: 14)).padding(.bottom)
                    Text(ownership.about ?? "").font(.system(size: 14))
                }
            }
        }.background(Color(.systemGray6))
    }
}

