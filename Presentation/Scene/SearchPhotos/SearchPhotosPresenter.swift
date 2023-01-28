//
//  SearchPhotosPresenter.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain

final class SearchPhotosPresenter {
    
    // MARK: private properties
    private weak var displayLogic: SearchPhotosViewController?
    private var router: SearchPhotosRouter?
    
    func setup(with displayLogic: SearchPhotosViewController?, router: SearchPhotosRouter?) {
        self.displayLogic = displayLogic
        self.router = router
    }
}

// MARK: - Responses
extension SearchPhotosPresenter {
    
    func present(isLoading: Bool) {
        
    }
    
    func present(error: Error) {
        present(isLoading: false)
    }
    
    func present(photos: [Photo]) {
        present(isLoading: false)
    }
}
