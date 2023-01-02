//
//  AddressView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import SwiftUI
import TikiSdk

struct OwnershipListView: View {
    
    let tikiSdk: TikiSdk
    
    init(_ tikiSdk: TikiSdk) {
        self.tikiSdk = tikiSdk
    }
    
    @State private var ownershipArray: [String] = []
    
    var body: some View {
        VStack{
            Text("Ownerships")
            NavigationView{
                List {
                    ForEach(0..<ownershipArray.count, id: \.self) { index in
                        let ownershipId = ownershipArray[index]
                        NavigationLink(destination: OwnershipDetailView(ownershipId, tikiSdk)) {
                            Text(ownershipId)
                        }
                    }
                    NavigationLink(destination: ContentView()) {
                        Text("+ new Ownership")
                    }
                }
            }
        }
    }
    

}

