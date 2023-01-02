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
    
    @State var ownershipArray: [TikiSdkOwnership] = []
    @State var isShowingGetOwnership = false
    @State var isShowingAddOwnership = false
    
    var body: some View {
        VStack{
            Text("Ownerships")
                List {
                    ForEach(0..<ownershipArray.count, id: \.self) { index in
                        let ownership = ownershipArray[index]
                        NavigationLink(destination: OwnershipDetailView(tikiSdk: tikiSdk, ownership: ownership)) {
                            Text(ownership.transactionId)
                        }
                    }
                    Button("Get Ownership") {
                            isShowingGetOwnership.toggle()
                            }
                            .sheet(isPresented: $isShowingGetOwnership) {
                                OwnershipGetView(tikiSdk: tikiSdk, ownershipArray: $ownershipArray, isShowingGetOwnership: $isShowingGetOwnership)
                            }
                    Button("Add Ownership") {
                            isShowingAddOwnership.toggle()
                            }
                            .sheet(isPresented: $isShowingAddOwnership) {
                                OwnershipAssignView(tikiSdk: tikiSdk, ownershipArray: $ownershipArray, isShowingAddOwnership: $isShowingAddOwnership)
                            }
                }
        }
    }
    

}

