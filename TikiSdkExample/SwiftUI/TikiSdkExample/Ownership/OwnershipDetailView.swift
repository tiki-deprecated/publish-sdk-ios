/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct OwnershipDetailView: View {
    
    @EnvironmentObject var appModel: TikiSdkExampleAppModel
    
    var body: some View {
        let ownership = appModel.ownership!
        VStack{
            Text("Ownership")
            List{
                HStack{
                    Text("Transaction Id")
                    Text(ownership.transactionId.prefix(16) + "...")
                }
                HStack{
                    Text("Source")
                    Text(ownership.source)
                }
                HStack{
                    Text("Origin")
                    Text(ownership.origin)
                }
                HStack{
                    Text("Type")
                    Text(ownership.type.rawValue)
                }
                HStack{
                    Text("Contains")
                    Text(ownership.contains.joined(separator: ","))
                }
                HStack{
                    Text("About")
                    Text(ownership.about ?? "")
                }
            }
        }
    }
}

