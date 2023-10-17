/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import SwiftUI
import TikiSdk

@main
struct TikiSdkExampleApp: App {
    
    @State var log: [String] = []
    @State var running: Bool = false
    
    var body: some Scene {
        WindowGroup {
            Button(action: {
                running = true
                Task{
                    try? await initTikiSdk()
                }
                
            }) {
                Text("Run").font(.custom("SpaceGrotesk-Regular", size:20))
            }
            .padding(.bottom, 48)
            .disabled(running)
            
            ScrollView{
                ScrollViewReader { scrollView in
                    VStack(alignment: .leading){
                        ForEach(0..<log.count, id: \.self) { index in
                            Text(log[index])
                        }
                        .onChange(of: log.count) { _ in
                            scrollView.scrollTo(log.count - 1)
                        }
                    }
                }
            }
        }
    }
    
    func initTikiSdk() async throws {
        let id = UUID().uuidString
        log.append("init sdk with id \(id)")
        try await TikiSdk.config()
            .initialize(
                id: id,
                publishingId: "e12f5b7b-6b48-4503-8b39-28e4995b5f88"
            )
        let ptr = NSUUID().uuidString
        log.append("PTR: \(ptr)")
        let title = try await TikiSdk.instance.trail.title.create(ptr: ptr, tags: [Tag(tag: TagCommon.ADVERTISING_DATA)])
        log.append("title: \(title!.id)")
        let license = try await TikiSdk.instance.trail.license.create(titleId: title!.id, uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)])], terms: "terms")
        log.append("license \(license!.id!)")
        let payable = try await TikiSdk.instance.trail.payable.create(licenseId: license!.id!, amount: "10", type: "test")
        log.append("payable \(payable!.id)")
        let receipt = try await TikiSdk.instance.trail.receipt.create(payableId: payable!.id, amount: "10")
        log.append("receipt \(receipt!.id)")
        log.append("=====================")
        running = false
    }
}
