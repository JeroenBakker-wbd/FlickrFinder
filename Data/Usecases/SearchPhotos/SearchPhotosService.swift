//
//  SearchPhotosService.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain
import Factory

struct SearchPhotosService: SearchPhotosWorker {
    
    @Injected(Container.Workers.api) private var apiWorker
    @Injected(Container.Mappers.searchPhotosResult) private var searchPhotosResultMapper
    
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
        request.httpMethod = APIMethod.get.rawValue
        
        do {
            let responseEntity: FlickrSearchPhotosAPIResponseEntity = try await apiWorker.sendRequest(for: request)
            guard let result = searchPhotosResultMapper.map(entity: responseEntity.photos) else {
                throw NetworkError.couldNotMap
            }
            
            return result
        } catch let error as FlickrAPIErrorEntity {
            throw FlickrSearchPhotoError(rawValue: error.code ?? 0)
        } catch let error {
            throw error
        }
    }
}
