//
//  SearchPhotosViewController+Factory.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

extension SearchPhotosViewController {
    
    convenience init(with router: SearchPhotosRouter) {
        let interactor = SearchPhotosInteractor()
        let presenter = SearchPhotosPresenter()
        
        self.init(interactor: interactor)
        
        interactor.setup(with: presenter, router: router)
        presenter.setup(with: self)
    }
}
