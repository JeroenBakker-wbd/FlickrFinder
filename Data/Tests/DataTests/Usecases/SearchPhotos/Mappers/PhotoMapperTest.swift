//
//  Created by Jeroen Bakker on 28/01/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Data
@testable import Domain

final class PhotoMapperTest: XCTestCase {

    private var sut: PhotoMapper!
    
    override func setUpWithError() throws {
        super.setUp()
        
        sut = PhotoMapper()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        
        sut = nil
    }
}

// MARK: - Tests
extension PhotoMapperTest {
    
    func test_map_onRequiredFields_shouldReturn() async {
        // given
        let entity = PhotoEntity(
            id: "id",
            title: "title",
            thumbnailURL: URL(string: "https://example.com")
        )
        
        // when
        let result = sut.map(entity: entity)

        // then
        XCTAssertNotNil(result)
    }
    
    func test_map_onMissingRequiredFieldId_shouldReturnNil() async {
        // given
        let entity = PhotoEntity(
            id: nil,
            title: "title",
            thumbnailURL: URL(string: "https://example.com")
        )
        
        // when
        let result = sut.map(entity: entity)

        // then
        XCTAssertNil(result)
    }
    
    func test_map_onMissingRequiredFieldTitle_shouldReturnNil() async {
        // given
        let entity = PhotoEntity(
            id: "id",
            title: nil,
            thumbnailURL: URL(string: "https://example.com")
        )
        
        // when
        let result = sut.map(entity: entity)

        // then
        XCTAssertNil(result)
    }
    
    func test_map_onMissingRequiredFieldThumb_shouldReturnNil() async {
        // given
        let entity = PhotoEntity(
            id: "id",
            title: "title",
            thumbnailURL: nil
        )
        
        // when
        let result = sut.map(entity: entity)

        // then
        XCTAssertNil(result)
    }
    
    func test_map_onNil_shouldReturnNil() async {
        // given
        let entity: PhotoEntity? = nil
        
        // when
        let result = sut.map(entity: entity)

        // then
        XCTAssertNil(result)
    }
}
