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
    
    func test_invoke_onFlickrAPIErrorEntity_shouldThrowSearchPhotoError() async throws {
        // given
        apiWorkerMock.mockedError = FlickrAPIErrorEntity(code: 1, message: "Something went wrong")
        
        // when
        do {
            _ = try await sut.invoke(with: "input", offset: 1, limit: 25)
        } catch FlickrSearchPhotoError.tooManyTags {
            // Success
        } catch {
            XCTFail("Expected FlickrSearchPhotoError tooManyTags")
        }
        
        // then
        XCTAssertEqual(1, apiWorkerMock.invokedSendRequestCount)
    }
    
    func test_invoke_onFlickrAPIErrorEntityCodeNil_shouldThrowUnknownAPIError() async throws {
        // given
        apiWorkerMock.mockedError = FlickrAPIErrorEntity(code: nil, message: "Something went wrong")
        
        // when
        do {
            _ = try await sut.invoke(with: "input", offset: 1, limit: 25)
        } catch FlickrSearchPhotoError.api(.unknown) {
            // Success
        } catch {
            XCTFail("Expected FlickrSearchPhotoError tooManyTags")
        }
        
        // then
        XCTAssertEqual(1, apiWorkerMock.invokedSendRequestCount)
    }
    
    func test_invoke_onError_shouldThrowError() async throws {
        // given
        apiWorkerMock.mockedError = NetworkError.forbidden
        
        // when
        do {
            _ = try await sut.invoke(with: "input", offset: 1, limit: 25)
        } catch NetworkError.forbidden {
            // Success
        } catch {
            XCTFail("Expected FlickrSearchPhotoError tooManyTags")
        }
        
        // then
        XCTAssertEqual(1, apiWorkerMock.invokedSendRequestCount)
    }
}
