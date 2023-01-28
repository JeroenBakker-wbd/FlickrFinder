//
//  SearchPhotosService.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain
import Factory

struct SearchPhotosService: SearchPhotosWorker {
    
    @Injected(Container.Singletons.urlSession) private var urlSession
    @Injected(Container.Mappers.searchPhotosResult) private var searchPhotosResultMapper
    
    /// To keep the scope small, lets not write our own API layer.
    /// Would be nice to make a backend enum and type safe paths once more API calls will be added.
    /// - Parameters:
    ///   - searchTerm: the given user input from the search textfield
    ///   - offset: pagination offset, starts with 1
    ///   - limit: how many results should be returned
    /// - Throws: Network Error
    /// - Returns: SearchPhotosResult
    func invoke(with searchTerm: String, offset: Int, limit: Int) async throws -> SearchPhotosResult {
        assert(offset > 0, "offset is expected to start at 1")
        
        // API documentation https://www.flickr.com/services/api/
        var urlComponents = URLComponents(string: "https://api.flickr.com/services/rest/")
        urlComponents?.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: "1508443e49213ff84d566777dc211f2a"),
            URLQueryItem(name: "content_type", value: "4"),
            URLQueryItem(name: "per_page", value: "\(limit)"),
            URLQueryItem(name: "page", value: "\(offset)"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "extras", value: "url_n,url_l,url_o"),
            URLQueryItem(name: "text", value: "\(searchTerm)")
        ]
        
        guard let requestURL = urlComponents?.url else {
            throw BaseError.general("Could not create queryItems for \(#function)")
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET" // in our API layer, would be an enum to make it type safe
        
        let (data, urlResponse) = try await urlSession.data(for: request)
        
        try Task.checkCancellation() // if our request got cancelled, don't bother mapping
        
        // In our API layer, this would be applied to every API call and moved in a seperate worker
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            throw NetworkError.couldNotGetHTTPURLResponse
        }
        
        switch httpUrlResponse.statusCode {
        case 200...299:
            let jsonDecoder = JSONDecoder()
            
            let responseEntity = try jsonDecoder.decode(FlickrSearchPhotosAPIResponseEntity.self, from: data)
            switch responseEntity.stat {
            case .ok:
                guard let result = searchPhotosResultMapper.map(entity: responseEntity.photos) else {
                    throw NetworkError.couldNotMap
                }
                
                return result
            case .fail, .none:
                let errorEntity = try jsonDecoder.decode(FlickrAPIErrorEntity.self, from: data)
                throw FlickrSearchPhotoError(rawValue: errorEntity.code ?? 0)
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
}
