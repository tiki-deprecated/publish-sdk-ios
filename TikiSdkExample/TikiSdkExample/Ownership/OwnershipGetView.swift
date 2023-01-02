//
//  OwnershipAssignView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import Foundation
import SwiftUI
import TikiSdk

struct OwnershipGetView : View{
    
    var tikiSdk: TikiSdk
    @Binding var ownershipArray: [TikiSdkOwnership]
    @Binding var isShowingGetOwnership: Bool
    
    @State var source : String = ""
    @State var origin: String = ""
    
    var body: some View {
        Form{
            TextField("Source", text: $source)
            TextField("Origin", text: $origin)
            Button("Get Ownership") {
                Task{
                    do{
                        let ownership: TikiSdkOwnership = try await tikiSdk.getOwnership(source: source, origin: origin.isEmpty ? nil : origin)!
                        ownershipArray.append(ownership)
                    }catch{
                        print(error)
                    }
                        isShowingGetOwnership = false
                }
            }
        }
    }
    
}
