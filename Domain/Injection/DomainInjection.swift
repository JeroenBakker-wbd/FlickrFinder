//
//  DomainInjection.swift
//  Domain
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Factory

extension Container {
    
    public enum Workers {
        public static let searchPhotos = Factory<SearchPhotosWorker?> { nil }
    }
}
