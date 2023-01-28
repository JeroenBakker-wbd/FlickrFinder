//
//  FlickrSearchPhotoError.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

enum FlickrSearchPhotoError: Error {
    case api(FlickrAPIError)
    case tooManyTags
    case unknownUser
    case parameterlessSearchesDisabled
    case noPermission
    case userDeleted
    
    init(rawValue: Int) {
        switch rawValue {
        case 1:
            self = .tooManyTags
        case 2:
            self = .unknownUser
        case 3:
            self = .parameterlessSearchesDisabled
        case 4:
            self = .noPermission
        case 5:
            self = .userDeleted
        default:
            self = .api(FlickrAPIError(rawValue: rawValue) ?? .unknown)
        }
    }
}
