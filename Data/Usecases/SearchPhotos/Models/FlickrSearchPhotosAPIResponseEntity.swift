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
}
