/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct ConsentView: View {
    
    
    let consent: TikiSdkConsent?
    
    var body: some View {
        List{
            Section{
                Text("Consent")
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
                    Text(consent!.transactionId).font(.system(size: 14))
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Destination").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                }
                Text("Paths: " + consent!.destination.paths.joined(separator: ", ")).font(.system(size: 14))
                Text("Uses: " + consent!.destination.uses.joined(separator: ", ")).font(.system(size: 14))
            }
            Section {
                VStack(alignment: .leading){
                    Text("About").foregroundColor(.blue).font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden).padding(.bottom)
                    Text(consent!.about ?? "").font(.system(size: 14))
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Reward").foregroundColor(.blue).font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden).padding(.bottom)
                    Text(consent!.reward ?? "").font(.system(size: 14))
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Expiry").foregroundColor(.blue).font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden).padding(.bottom)
                    Text(consent!.expiry == nil ? "Never" :  getExpiryString(consent!)).font(.system(size: 14))
                }
            }
        }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
        .background(Color(.systemGray6))
    }
    
    func getExpiryString(_ consent: TikiSdkConsent) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return formatter.string(from: consent.expiry!)
    }
}

