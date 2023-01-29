//
//  SearchPhotosItem.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import Foundation

enum SearchPhotosItem {
    case skeletonLoading(id: String)
    case results(id: String)
    case paginationLoading(id: String)
    
    var reuseIdentifier: String {
        switch self {
        case .skeletonLoading:
            return ""
        case .results:
            return ""
        case .paginationLoading:
            return ""
        }
    }
}

extension SearchPhotosItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .skeletonLoading(let id):
            hasher.combine(id)
        case .results(let id):
            hasher.combine(id)
        case .paginationLoading(let id):
            hasher.combine(id)
        }
    }
}
