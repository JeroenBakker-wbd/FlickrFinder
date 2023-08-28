//
//  FlickrAPIError.swift
//  Data
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

enum FlickrAPIError: Int, Error {
    case unknown = 0
    case apiUnavailable = 10
    case invalidMachineTags = 11
    case exceededMaxAllowedMachineTags = 12
    case invalidUserId = 17
    case illogicalArguments = 18
    case invalidAPIKey = 100
    case serviceUnavailble = 105
    case writeOperationFailed = 106
    case formatNotFound = 111
    case methodNotFound = 112
    case invalidSOAP = 114
    case invalidXML = 115
    case badURL = 116
}
