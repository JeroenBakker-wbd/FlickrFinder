//
//  SearchPhotosItem.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import Foundation

enum SearchPhotosItem {
    case results(SearchPhotosResultCell.ViewModel)
    case loading(SearchPhotosLoadingCell.ViewModel)
    
    var reuseIdentifier: String {
        switch self {
        case .results:
            return SearchPhotosResultCell.reuseIdentifier
        case .loading:
            return SearchPhotosLoadingCell.reuseIdentifier
        }
    }
}

// MARK: - Hashable
extension SearchPhotosItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .results(let viewModel):
            hasher.combine(viewModel.uniqueId)
        case .loading(let viewModel):
            hasher.combine(viewModel)
        }
    }
}
