//
//  OwnershipAssignView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import Foundation
import SwiftUI
import TikiSdk

struct OwnershipAssignView : View{
    
    var tikiSdk: TikiSdk
    let typeOptions: [TikiSdkDataTypeEnum] = [TikiSdkDataTypeEnum.stream, TikiSdkDataTypeEnum.point, TikiSdkDataTypeEnum.pool]
    
    @Binding var ownershipArray: [TikiSdkOwnership]
    @Binding var isShowingAddOwnership: Bool
    
    @State var source : String = ""
    @State var type: TikiSdkDataTypeEnum = TikiSdkDataTypeEnum.point
    @State var contains: String = ""
    @State var about: String = ""
    @State var origin: String = ""
    
    var body: some View {
        NavigationView {
            Form{
                TextField("Source", text: $source)
                Picker(selection: self.$type, label: Text("Type: \(self.type.rawValue)")) {
                    ForEach(0 ..< typeOptions.count) {
                        Text(self.typeOptions[$0].rawValue)
                    }
                }
                TextField("Contains", text: $contains)
                TextField("About", text: $about)
                TextField("Origin", text: $origin)
                Button("Assign Ownership") {
                    let containsArr: [String] = contains.split(separator: ",").map { String($0) }
                    Task{
                        do{
                            let _: String = try await tikiSdk.assignOwnership(source: source, type: type, contains: containsArr, about: about.isEmpty ? nil : about, origin: origin.isEmpty ? nil : origin)
                            let ownership: TikiSdkOwnership = try await tikiSdk.getOwnership(source: source, origin: origin.isEmpty ? nil : origin)!
                            ownershipArray.append(ownership)
                        }catch{
                            print(error)
                        }
                        isShowingAddOwnership = false
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}
