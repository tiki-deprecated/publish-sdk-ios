/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

struct StreamCreateView: View {
    
    @EnvironmentObject var appModel: TikiSdkExampleAppModel

    @State private var httpMethod: String = "POST"
    @State private var interval: String = "Every 1 second"
    @State private var url: String = "https://postman-echo.com/post"
    
    let httpMethods = ["POST", "GET"]
    let intervals = ["Every 1 second", "Every 15 seconds", "Every 30 seconds", "Every 60 seconds"]
    let intervalInts = [1,15,30,60]
    
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
                Picker("Interval", selection: $interval) {
                   ForEach(intervals, id: \.self) {
                       Text($0)
                   }
                }
            }.offset(x: 0, y: -30).edgesIgnoringSafeArea(.bottom)
        }.background(Color(.systemGray6)).onDisappear{
            appModel.stream.httpMethod = httpMethod
            appModel.stream.interval = intervalInts[intervals.firstIndex(of: interval)!]
            appModel.stream.url = url
            print(appModel)
        }
    }
}
