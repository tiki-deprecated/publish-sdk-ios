/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct DestinationEditView: View {
    
    @Binding var url: String
    @Binding var httpMethod: String
    @Binding var interval: Int
    
    let httpMethods = ["POST", "GET"]
    let intervals = ["Every 1 second", "Every 15 seconds", "Every 30 seconds", "Every 60 seconds"]
    let intervalInts = [1,15,30,60]
    
    @State var intervalStr = "Every 15 seconds"
    
    var body: some View {

        VStack(alignment: .leading){
            Text("Destination").fontWeight(.heavy)
                .font(.largeTitle).padding()
                .multilineTextAlignment(.leading)
            List {
                TextField("URL", text: $url)
                Picker("HTTP Method", selection: $httpMethod) {
                   ForEach(httpMethods, id: \.self) {
                       Text($0)
                   }
                }
                Picker("Interval", selection: $intervalStr) {
                   ForEach(intervals, id: \.self) {
                       Text($0)
                   }
                }.onAppear{
                    intervalStr = intervals[intervalInts.firstIndex(of: interval)!]
                }.onChange(of: intervalStr, perform: { newInterval in
                    interval = intervalInts[intervals.firstIndex(of: newInterval)!]
                })
            }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
        }.background(Color(.systemGray6))
    }
}
