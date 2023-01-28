//
//  DataInjection.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain
import Factory

// MARK: - Singletons
extension Container: AutoRegistering {
    
    public static func registerAllServices() {
        Workers.searchPhotos.register { SearchPhotosService() }
    }
    
    enum Singletons {
        public static let urlSession = Factory<URLSession>(scope: .singleton) { URLSession.shared }
    }
    
    public enum Workers {
        static let api = Factory<APIWorker> { APIService() }
    }
    
    enum Mappers {
        public static let searchPhotosResult = Factory<SearchPhotosResultMapper> { SearchPhotosResultMapper() }
        public static let photo = Factory<PhotoMapper> { PhotoMapper() }
    }
}
