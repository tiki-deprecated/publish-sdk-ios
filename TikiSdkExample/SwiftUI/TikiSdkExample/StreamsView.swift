//
//  AddressView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import SwiftUI
import TikiSdk

struct StreamsView: View {
    
    List
    
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    Text("Address")
                    List {
                        ForEach(0..<tikiSdkArray.count, id: \.self) { index in
                            let tikiSdk = tikiSdkArray[index]
                            let addr = tikiSdk.address!.prefix(16)
                            NavigationLink(destination: OwnershipListView(tikiSdk: tikiSdk)) {
                                Text(addr + "...")
                            }
                        }
                        Button("+ new address") {
                            if(!isLoading){
                                isLoading = true
                                Task {
                                    let tikiSdk = try await TikiSdkExampleService.initTikiSdk()
                                    tikiSdkArray.append(tikiSdk)
                                    isLoading = false
                                }
                            }
                        }.disabled(isLoading)
                    }
                }
            }
        }
    }
    

}

