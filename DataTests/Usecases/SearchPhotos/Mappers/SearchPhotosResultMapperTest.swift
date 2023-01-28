//
//  Created by Jeroen Bakker on 28/01/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Data
@testable import Domain

final class SearchPhotosResultMapperTest: XCTestCase {

    private var sut: SearchPhotosResultMapper!
    
    override func setUpWithError() throws {
        super.setUp()
        
        sut = SearchPhotosResultMapper()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        
        sut = nil
    }
}

// MARK: - Tests
extension SearchPhotosResultMapperTest {
    
    func test_map_onEmpty_shouldReturnDefaultValues() async {
        // given
        let entity = SearchPhotosResponseEntity(
            page: nil,
            pages: nil,
            perpage: nil,
            total: nil,
            photos: nil
        )
        
        // when
        let result = sut.map(entity: entity)

        // then
        XCTAssertEqual(1, result?.offset)
        XCTAssertEqual(0, result?.limit)
        XCTAssertEqual(0, result?.totalPhotos)
        XCTAssertEqual(true, result?.photos.isEmpty)
    }
    
    func test_map_onNonEmpty_shouldNotReturnDefaultValues() async {
        // given
        let entity = SearchPhotosResponseEntity(
            page: 5,
            pages: 20,
            perpage: 25,
            total: 1234,
            photos: [
                PhotoEntity(id: "id", title: "title", thumbnailURL: URL(string: "https://example.com"))
            ]
        )
        
        // when
        let result = sut.map(entity: entity)

        // then
        XCTAssertEqual(5, result?.offset)
        XCTAssertEqual(25, result?.limit)
        XCTAssertEqual(1234, result?.totalPhotos)
        XCTAssertEqual(1, result?.photos.count)
    }
    
    func test_map_onNil_shouldReturnNil() async {
        // given
        let entity: SearchPhotosResponseEntity? = nil
        
        // when
        let result = sut.map(entity: entity)

        // then
        XCTAssertNil(result)
    }
}
