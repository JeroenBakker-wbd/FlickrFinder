//
//  APIService.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain
import Factory
import Foundation

struct APIService: APIWorker {
    
    @Injected(Container.Singletons.urlSession) private var urlSession
    
    func sendRequest<T: FlickrAPIResponseEntity>(for request: URLRequest) async throws -> T {
        let (data, urlResponse) = try await urlSession.data(for: request)
        
        try Task.checkCancellation() // if our request got cancelled, don't bother mapping
        
        // In our API layer, this would be applied to every API call and moved in a seperate worker
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            throw NetworkError.couldNotGetHTTPURLResponse
        }
        
        switch httpUrlResponse.statusCode {
        case 200...299:
            let jsonDecoder = JSONDecoder()
            let responseEntity = try jsonDecoder.decode(T.self, from: data)
            switch responseEntity.stat {
            case .ok:
                return responseEntity
            case .fail, .none:
                let errorEntity = try jsonDecoder.decode(FlickrAPIErrorEntity.self, from: data)
                throw errorEntity
            }
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 500:
            throw NetworkError.internalServerError
        default:
            throw NetworkError.statusCode(httpUrlResponse.statusCode)
        }
    }

    func anEmptyTestWhichShouldBeReportedAsACodeSmell() {
        
    }
}
