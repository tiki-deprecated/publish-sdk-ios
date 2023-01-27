/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct ConsentView: View {
    
    @EnvironmentObject var appModel: TikiSdkExampleAppModel
    
    var body: some View {
        let consent = appModel.consent!
        List{
            Section{
                Text("Consent").fontWeight(.heavy)
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
                    Text(consent.transactionId)
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Destination").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                }
                Text("Paths: " + consent.destination.paths.joined(separator: ", "))
                Text("Uses: " + consent.destination.uses.joined(separator: ", "))
            }
            Section {
                VStack(alignment: .leading){
                    Text("About").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                    Text(consent.about ?? "")
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Reward").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                    Text(consent.reward ?? "")
                }
            }
            Section {
                VStack(alignment: .leading){
                    Text("Expiry").foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                    Text(consent.expiry == nil ? "Never" :  getExpiryString(consent))
                }
            }
        }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
        .background(Color(.systemGray6))
    }
    
    func getExpiryString(_ consent: TikiSdkConsent) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let date = Date(timeIntervalSince1970: TimeInterval(consent.expiry!/1000))
        return formatter.string(from: date)
    }
}

