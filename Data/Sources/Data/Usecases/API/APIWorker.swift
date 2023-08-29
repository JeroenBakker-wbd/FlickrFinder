//
//  APIWorker.swift
//  Domain
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

protocol APIWorker {
    func sendRequest<T: FlickrAPIResponseEntity>(for request: URLRequest) async throws -> T
}
