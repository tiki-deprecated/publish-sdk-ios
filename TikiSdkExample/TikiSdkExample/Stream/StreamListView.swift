//
//  AddressView.swift
//  TikiSdkExample
//
//  Created by Ricardo on 31/12/22.
//

import SwiftUI
import TikiSdk

struct StreamListView: View {
    
    var tikiSdk: TikiSdk
    
    @State private var streamArray: [Stream] = []
    @State private var data: String = ""
    
    var body: some View {
        
        VStack{
            Text("Streams")
            List {
                ForEach(0..<streamArray.count, id: \.self) { index in
                    let stream = streamArray[index]
                    NavigationLink(destination: StreamDetailView(tikiSdk: tikiSdk, stream: stream)) {
                        Text(stream.data)
                    }
                }
            }
            Form{
                Section(header: Text("Add new Stream")) {
                    TextField("Data to send", text: $data)
                    Button("+ new Stream") {
                        Task{
                            let source: String = UUID().uuidString
                            do{
                                let _: String = try await tikiSdk.assignOwnership(source: source, type: TikiSdkDataTypeEnum.stream, contains: ["generic data"], about: "Data stream created with TIKI SDK Sample App")
                                let stream = Stream(source: source, data: data)
                                streamArray.append(stream)
                                data = ""
                            }catch{
                                print(error.localizedDescription, error)
                            }
                        }
                    }.disabled(data.isEmpty)
                }
            }
        }
    }
}

