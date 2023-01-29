//
//  PhotoDetailViewController+Factory.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import Domain

extension PhotoDetailViewController {
    
    convenience init(with router: PhotoDetailRouter, photo: Photo) {
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter()
        
        self.init(interactor: interactor)
        
        interactor.setup(with: presenter, router: router, photo: photo)
        presenter.setup(with: self)
    }
}
