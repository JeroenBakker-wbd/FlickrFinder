//
//  Created by Jeroen Bakker on 29/01/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import Factory
@testable import Data
@testable import Domain

final class APIServiceTest: XCTestCase {

    private var urlSessionMock: URLSessionMock!
    private var sut: APIService!
    
    override func setUpWithError() throws {
        super.setUp()
        
        urlSessionMock = URLSessionMock()
        Container.Singletons.urlSession.register { self.urlSessionMock }
        
        sut = APIService()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        
        sut = nil
    }
}

// MARK: - Tests
extension APIServiceTest {
    
    func test_sendRequest_onError_shouldThrowError() async {
        // given
        urlSessionMock.stubbedError = NetworkError.forbidden
        
        // when
        do {
            let _: FlickrSearchPhotosAPIResponseEntity = try await sut.sendRequest(for: URLRequest(url: URL(string: "https://example.com")!))
        } catch NetworkError.forbidden {
            // Success
        } catch let error {
            XCTFail("Received \(error)")
        }
    }
    
    func test_sendRequest_onNonHttpUrlResponse_shouldThrowError() async {
        // given
        urlSessionMock.stubbedData = Data()
        urlSessionMock.stubbedResponse = URLResponse()
        
        // when
        do {
            let _: FlickrSearchPhotosAPIResponseEntity = try await sut.sendRequest(for: URLRequest(url: URL(string: "https://example.com")!))
        } catch NetworkError.couldNotGetHTTPURLResponse {
            // Success
        } catch let error {
            XCTFail("Received \(error)")
        }
    }
    
    func test_sendRequest_onStatusCode401_shouldThrowError() async {
        // given
        urlSessionMock.stubbedData = Data()
        urlSessionMock.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 401,
            httpVersion: nil,
            headerFields: nil
        )
        
        // when
        do {
            let _: FlickrSearchPhotosAPIResponseEntity = try await sut.sendRequest(for: URLRequest(url: URL(string: "https://example.com")!))
        } catch NetworkError.unauthorized {
            // Success
        } catch let error {
            XCTFail("Received \(error)")
        }
    }
    
    func test_sendRequest_onStatusCode403_shouldThrowError() async {
        // given
        urlSessionMock.stubbedData = Data()
        urlSessionMock.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 403,
            httpVersion: nil,
            headerFields: nil
        )
        
        // when
        do {
            let _: FlickrSearchPhotosAPIResponseEntity = try await sut.sendRequest(for: URLRequest(url: URL(string: "https://example.com")!))
        } catch NetworkError.forbidden {
            // Success
        } catch let error {
            XCTFail("Received \(error)")
        }
    }
    
    func test_sendRequest_onStatusCode500_shouldThrowError() async {
        // given
        urlSessionMock.stubbedData = Data()
        urlSessionMock.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        // when
        do {
            let _: FlickrSearchPhotosAPIResponseEntity = try await sut.sendRequest(for: URLRequest(url: URL(string: "https://example.com")!))
        } catch NetworkError.internalServerError {
            // Success
        } catch let error {
            XCTFail("Received \(error)")
        }
    }
    
    func test_sendRequest_onStatusCode404_shouldThrowError() async {
        // given
        urlSessionMock.stubbedData = Data()
        urlSessionMock.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        
        // when
        do {
            let _: FlickrSearchPhotosAPIResponseEntity = try await sut.sendRequest(for: URLRequest(url: URL(string: "https://example.com")!))
        } catch NetworkError.statusCode(404) {
            // Success
        } catch let error {
            XCTFail("Received \(error)")
        }
    }
    
    func test_sendRequest_onFlickrAPIResponseEntityNo_shouldThrowErrorEntity() async throws {
        // given
        let entity = FlickrSearchPhotosAPIResponseEntity(stat: .fail)
        urlSessionMock.stubbedData = try JSONEncoder().encode(entity)
        urlSessionMock.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // when
        do {
            let _: FlickrSearchPhotosAPIResponseEntity = try await sut.sendRequest(for: URLRequest(url: URL(string: "https://example.com")!))
        } catch let error as FlickrAPIErrorEntity {
            // Success
            XCTAssertNil(error.code)
            XCTAssertNil(error.message)
        } catch let error {
            XCTFail("Received \(error)")
        }
    }
    
    func test_sendRequest_onFlickrAPIResponseEntityYes_shouldReturnResult() async throws {
        // given
        let entity = FlickrSearchPhotosAPIResponseEntity(stat: .ok)
        urlSessionMock.stubbedData = try JSONEncoder().encode(entity)
        urlSessionMock.stubbedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 210,
            httpVersion: nil,
            headerFields: nil
        )
        
        // when
        do {
            let result: FlickrSearchPhotosAPIResponseEntity = try await sut.sendRequest(for: URLRequest(url: URL(string: "https://example.com")!))
            XCTAssertNil(result.photos)
        } catch let error {
            XCTFail("Received \(error)")
        }
    }
}
