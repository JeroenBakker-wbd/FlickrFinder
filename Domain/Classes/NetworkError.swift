//
//  NetworkError.swift
//  Domain
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

public enum NetworkError: Error {
    case couldNotMap
    case couldNotGetHTTPURLResponse
    case unauthorized
    case forbidden
    case internalServerError
    case statusCode(Int)
}
