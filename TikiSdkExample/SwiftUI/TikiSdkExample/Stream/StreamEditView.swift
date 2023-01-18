/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct StreamEditView: View {
    
    @EnvironmentObject var appModel: TikiSdkExampleAppModel
    
    let httpMethods = ["POST", "GET"]
    let intervals = ["Every 1 second", "Every 15 seconds", "Every 30 seconds", "Every 60 seconds"]
    let intervalInts = [1,15,30,60]
    
    @State private var interval: String = "Every 1 second"
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Destination").fontWeight(.heavy)
                .font(.largeTitle).padding()
                .multilineTextAlignment(.leading)
            List {
                TextField("URL", text: $appModel.stream.url)
                Picker("HTTP Method", selection: $appModel.stream.httpMethod) {
                   ForEach(httpMethods, id: \.self) {
                       Text($0)
                   }
                }
                Picker("Interval", selection: $interval) {
                   ForEach(intervals, id: \.self) {
                       Text($0)
                   }
                }.onAppear{
                    interval = intervals[intervalInts.firstIndex(of: appModel.stream.interval)!]
                }.onChange(of: interval, perform: { newInterval in
                    appModel.stream.interval = intervalInts[intervals.firstIndex(of: newInterval)!]
                })
            }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
        }.background(Color(.systemGray6))
    }
}
