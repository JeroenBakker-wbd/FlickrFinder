//
//  SearchPhotosPresenter.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

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
    
}
