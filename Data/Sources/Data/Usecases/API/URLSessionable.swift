//
//  URLSessionable.swift
//  Data
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import Foundation

protocol URLSessionable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionable { }
