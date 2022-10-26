//
//  tiki_sdk_iosTests.swift
//  tiki_sdk_iosTests
//
//  Created by Ricardo on 12/10/22.
//

import XCTest
@testable import tiki_sdk_ios
@testable import tiki_sdk_flutter_plugin

class tiki_sdk_iosTests: XCTestCase {
    
    let apiKey = ""
    let origin = "com.mytiki.tiki_sdk_iosTests"
    var sdk : TikiSdk? = nil

    func testInitSDK() throws {
        sdk = TikiSdk(apiKey: apiKey, origin: origin)
        assert(true)
    }

    func testCreateOwnership() async throws {
        sdk = TikiSdk(apiKey: apiKey, origin: origin)
        let id = try await sdk!.assignOwnership(source: "test case", type: "data_point", contains: ["nothing"])
        assert(id!.isEmpty == false)
    }

    func testGiveConsent() async throws {
        sdk = TikiSdk(apiKey: apiKey, origin: origin)
        let destination = TikiSdkFlutterDestination.init(uses: ["*"], paths: ["*"])
        try await sdk!.modifyConsent(source: "test case", destination: destination, about: nil, reward: nil)
        let consent : TikiSdkFlutterConsent? = try await sdk!.getConsent(source: "test case")
        assert(consent?.destination.paths[0] == "*")
        assert(consent?.destination.uses[0] == "*")
    }
    
    func testModifyConsent() async throws {
        sdk = TikiSdk(apiKey: apiKey, origin: origin)
        let destination = TikiSdkFlutterDestination.init(uses: ["*"], paths: ["*"])
        try await sdk!.modifyConsent(source: "test case", destination: destination, about: nil, reward: nil)
        var consent : TikiSdkFlutterConsent? = try await sdk!.getConsent(source: "test case")
        assert(consent!.destination.paths[0] == "*")
        assert(consent!.destination.uses[0] == "*")
        try await sdk!.modifyConsent(source: "test case", destination: destination, about: nil, reward: nil)
        consent = try await sdk!.getConsent(source: "test case")
        assert(consent!.destination.paths[0].isEmpty)
        assert(consent!.destination.uses[0].isEmpty)
    }
    
    func testApplyConsent() async throws {
        var ok = false
        sdk = TikiSdk(apiKey: apiKey, origin: origin)
        let destination = TikiSdkFlutterDestination.init(uses: ["*"], paths: ["*"])
        try await sdk!.modifyConsent(source: "test case", destination: destination, about: nil, reward: nil)
        try await sdk!.applyConsent(source: "test case", destination: destination, request: { (response) -> Void in
            ok = false
        }, onBlock:{ (response) -> Void in
            ok = false
        })
        assert(ok)
    }
}
