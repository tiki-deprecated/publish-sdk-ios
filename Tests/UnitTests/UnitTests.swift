//
//  UnitTests.swift
//  UnitTests
//
//  Created by Ricardo on 22/03/23.
//

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
    
    func testCodableLicenseUsecase(){
        do{
            let licenseUsecase = LicenseUsecase(LicenseUsecaseEnum.support)
            let jsonString = String(data: try JSONEncoder().encode(licenseUsecase), encoding: .utf8)!
            let decoded: LicenseUsecase = try JSONDecoder().decode(LicenseUsecase.self, from: Data(jsonString.utf8))
            XCTAssertEqual(licenseUsecase.value, decoded.value)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCodableCustomLicenseUsecase(){
        do{
            let licenseUsecase = LicenseUsecase("abc")
            let jsonString = String(data: try JSONEncoder().encode(licenseUsecase), encoding: .utf8)!
            let decoded: LicenseUsecase = try JSONDecoder().decode(LicenseUsecase.self, from: Data(jsonString.utf8))
            XCTAssertEqual(licenseUsecase.value, decoded.value)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }

}
