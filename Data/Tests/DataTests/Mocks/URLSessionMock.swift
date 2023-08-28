//
//  URLSessionMock.swift
//  DataTests
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import Foundation
@testable import Data

final class URLSessionMock: URLSessionable {
    
    var stubbedData: Data!
    var stubbedResponse: URLResponse!
    var stubbedError: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let stubbedError {
            throw stubbedError
        }
        
        return (stubbedData, stubbedResponse)
    }
}
