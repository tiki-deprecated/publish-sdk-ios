import XCTest
@testable import TikiSdk

final class TikiSdkTests: XCTestCase {
    func testExample() throws {
        let sdk = TikiSdk(origin: "sdkTests")
        XCTAssertNotNil(sdk)
    }
}
