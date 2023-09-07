/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import XCTest
import TikiSdk

final class CodableTests: XCTestCase {
    
    func testCodableTag(){
        do{
            let titleTag = Tag(tag: TagCommon.EMAIL_ADDRESS)
            XCTAssertEqual(titleTag.toString(),TagCommon.EMAIL_ADDRESS.rawValue)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCodableCustomTag(){
        do{
            let titleTag = Tag.from(tag: "abc")
            XCTAssertEqual(titleTag.toString(), "custom:abc")
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCodableUsecase(){
        do{
            let usecase = Usecase(UsecaseCommon.support)

            XCTAssertEqual(usecase.value, UsecaseCommon.support.rawValue)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCodableCustomUsecase(){
        do{
            let usecase = Usecase("abc")
            XCTAssertEqual(usecase.value, "custom:abc")
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

}
