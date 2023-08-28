//
//  FlickrSearchPhotosAPIResponseEntity.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

struct FlickrSearchPhotosAPIResponseEntity: FlickrAPIResponseEntity {

    let stat: FlickrAPIResponseStat?
    let photos: SearchPhotosResponseEntity?
    
    #if DEBUG
    init(stat: FlickrAPIResponseStat? = nil, photos: SearchPhotosResponseEntity? = nil) {
        self.stat = stat
        self.photos = photos
    }
    #endif
}
