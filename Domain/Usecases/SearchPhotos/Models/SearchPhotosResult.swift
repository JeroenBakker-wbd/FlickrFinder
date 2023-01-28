//
//  SearchPhotosResult.swift
//  Domain
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

public struct SearchPhotosResult {
    public init(offset: Int, limit: Int, totalPhotos: Int, photos: [Photo]) {
        self.offset = offset
        self.limit = limit
        self.totalPhotos = totalPhotos
        self.photos = photos
    }
    
    public let offset: Int
    public let limit: Int
    public let totalPhotos: Int
    public let photos: [Photo]
}
