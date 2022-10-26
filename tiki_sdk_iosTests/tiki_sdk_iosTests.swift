//
//  tiki_sdk_iosTests.swift
//  tiki_sdk_iosTests
//
//  Created by Ricardo on 12/10/22.
//

import XCTest
import PromiseKit

class tiki_sdk_iosTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func initSDK() throws {
        let a = Promise.init()
        try a.wait();
        assert(true)
    }

    func createOwnership() throws {
        assert(true)
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func giveConsent() throws {
        assert(true)
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func modifyConsent() throws {
        assert(true)
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func applyConsent() throws {
        assert(true)
        
    }
}
