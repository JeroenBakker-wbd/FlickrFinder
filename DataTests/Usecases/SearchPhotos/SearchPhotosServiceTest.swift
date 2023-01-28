//
//  Created by Jeroen Bakker on 28/01/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import Factory
@testable import Domain
@testable import Data

final class SearchPhotosServiceTest: XCTestCase {

    private var apiWorkerMock: APIWorkerMock!
    private var sut: SearchPhotosService!
    
    override func setUpWithError() throws {
        super.setUp()
        
        apiWorkerMock = .init()
        
        Container.Workers.api.register { self.apiWorkerMock }
        
        sut = SearchPhotosService()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        
        sut = nil
    }
}

// MARK: - Tests
extension SearchPhotosServiceTest {
    
    func test_invoke_onRequiredOffsetAndResponseWithPhotos_shouldPerformAPI() async throws {
        // given
        apiWorkerMock.mockedResponse = FlickrSearchPhotosAPIResponseEntity(
            photos: SearchPhotosResponseEntity()
        )
        
        // when
        _ = try await sut.invoke(with: "input", offset: 1, limit: 25)
        
        // then
        XCTAssertEqual(1, apiWorkerMock.invokedSendRequestCount)
    }
    
    func test_invoke_onRequiredOffsetAndEmptyPhotosResponse_shouldThrowError() async throws {
        // given
        apiWorkerMock.mockedResponse = FlickrSearchPhotosAPIResponseEntity(
            photos: nil
        )
        
        // when
        do {
            _ = try await sut.invoke(with: "input", offset: 1, limit: 25)
        } catch NetworkError.couldNotMap {
            // success
        } catch {
            XCTFail("Expected network errror")
        }
        
        // then
        XCTAssertEqual(1, apiWorkerMock.invokedSendRequestCount)
    }
}
