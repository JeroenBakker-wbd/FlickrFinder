//
//  APIWorkerMock.swift
//  DataTests
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation
@testable import Domain
@testable import Data

final class APIWorkerMock: APIWorker {
    
    var mockedError: Error?
    var mockedResponse: Any?
    
    private(set) var invokedSendRequestCount: Int = 0
    func sendRequest<T: FlickrAPIResponseEntity>(for request: URLRequest) async throws -> T {
        invokedSendRequestCount += 1
        
        if let mockedError {
            throw mockedError
        } else if let mockedResponse = mockedResponse as? T {
            return mockedResponse
        }
        
        throw BaseError.general("Did not provide mocks")
    }
}
