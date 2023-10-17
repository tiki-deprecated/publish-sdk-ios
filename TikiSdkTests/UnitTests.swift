/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import XCTest
import TikiSdk

final class CodableTests: XCTestCase {
    
    func testCodableTag(){
        let titleTag = Tag(tag: TagCommon.EMAIL_ADDRESS)
        XCTAssertEqual(titleTag.toString(),TagCommon.EMAIL_ADDRESS.rawValue)
    }
    
    func testCodableCustomTag(){
        let titleTag = Tag.from(tag: "abc")
        XCTAssertEqual(titleTag.toString(), "custom:abc")
    }
    
    func testCodableUsecase(){
        let usecase = Usecase(usecase: UsecaseCommon.support)
        XCTAssertEqual(usecase.toString(), UsecaseCommon.support.rawValue)
    }
    
    func testCodableCustomUsecase(){
        let usecase = Usecase.custom(usecase: "abc")
        XCTAssertEqual(usecase.toString(), "custom:abc")
    }

}
