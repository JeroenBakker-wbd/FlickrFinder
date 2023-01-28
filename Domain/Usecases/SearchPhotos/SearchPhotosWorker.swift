//
//  SearchPhotosWorker.swift
//  Domain
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

public protocol SearchPhotosWorker {
    func invoke(with searchTerm: String, offset: Int, limit: Int) async throws -> SearchPhotosResult
}
