//
//  FlickrSearchPhotoError.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

enum FlickrSearchPhotoError: Error, Equatable {
    case api(FlickrAPIError)
    case tooManyTags
    case unknownUser
    case parameterlessSearchesDisabled
    case noPermission
    case userDeleted
    case aNewCaseWhichWillBeTested1
    case aNewCaseWhichWillBeTested2
    case aNewCaseWhichWillBeTested3
    case aNewCaseWhichWillBeTested4
    case aNewCaseWhichWillBeTested5
    case aNewCaseWhichWillBeTested6
    
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
        case 6:
            self = .aNewCaseWhichWillBeTested1
        case 7:
            self = .aNewCaseWhichWillBeTested2
        case 8:
            self = .aNewCaseWhichWillBeTested3
        case 9:
            self = .aNewCaseWhichWillBeTested4
        case 10:
            self = .aNewCaseWhichWillBeTested5
        case 11:
            self = .aNewCaseWhichWillBeTested6 // not tested
        default:
            self = .api(FlickrAPIError(rawValue: rawValue) ?? .unknown)
        }
    }
}
