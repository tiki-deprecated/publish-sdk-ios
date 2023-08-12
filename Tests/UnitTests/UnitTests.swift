/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import XCTest
import TikiSdk

final class CodableTests: XCTestCase {
    
    func testCodableTitleTag(){
        do{
            let titleTag = TitleTag(TitleTagEnum.emailAddress)
            let jsonString = String(data: try JSONEncoder().encode(titleTag), encoding: .utf8)!
            let decoded: TitleTag = try JSONDecoder().decode(TitleTag.self, from: Data(jsonString.utf8))
            XCTAssertEqual(titleTag.value, decoded.value)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCodableCustomTitleTag(){
        do{
            let titleTag = TitleTag("abc")
            let jsonString = String(data: try JSONEncoder().encode(titleTag), encoding: .utf8)!
            let decoded: TitleTag = try JSONDecoder().decode(TitleTag.self, from: Data(jsonString.utf8))
            XCTAssertEqual(titleTag.value, decoded.value)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCodableUsecase(){
        do{
            let Usecase = Usecase(UsecaseCommon.support)
            let jsonString = String(data: try JSONEncoder().encode(Usecase), encoding: .utf8)!
            let decoded: Usecase = try JSONDecoder().decode(Usecase.self, from: Data(jsonString.utf8))
            XCTAssertEqual(Usecase.value, decoded.value)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCodableCustomUsecase(){
        do{
            let Usecase = Usecase("abc")
            let jsonString = String(data: try JSONEncoder().encode(Usecase), encoding: .utf8)!
            let decoded: Usecase = try JSONDecoder().decode(Usecase.self, from: Data(jsonString.utf8))
            XCTAssertEqual(Usecase.value, decoded.value)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

}
