//
//  AddressView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import SwiftUI
import TikiSdk

struct AddressView: View {
    
    let tikiSdkService: TikiSdkExampleService
    
    init(_ tikiSdkService: TikiSdkExampleService) {
        self.tikiSdkService = tikiSdkService
    }
    
    @State var path: [String] = []
    @State private var tikiSdkArray: [TikiSdk] = []
    @State private var isLoading = false
    
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    Text("Address")
                    List {
                        ForEach(0..<tikiSdkArray.count, id: \.self) { index in
                            let tikiSdk = tikiSdkArray[index]
                            let addr = tikiSdk.address
                            NavigationLink(destination: OwnershipListView(tikiSdk: tikiSdk)) {
                                Text(addr!)
                            }
                        }
                        Button("+ new address") {
                            if(!isLoading){
                                isLoading = true
                                Task {
                                    let tikiSdk = try await tikiSdkService.initTikiSdk()
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

