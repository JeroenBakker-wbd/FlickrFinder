//
//  PhotoDetailInteractor.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import Domain
import Factory

enum PhotoDetailRequest {
    case viewDidLoad
}

final class PhotoDetailInteractor {
        
    private var photo: Photo!
    private var presenter: PhotoDetailPresenter?
    private var router: PhotoDetailRouter?
    
    // MARK: Lifecycle
    init() { }
    
    // MARK: Internal methods
    func setup(with presenter: PhotoDetailPresenter, router: PhotoDetailRouter, photo: Photo) {
        self.presenter = presenter
        self.router = router
        self.photo = photo
    }
}

// MARK: - Requests
extension PhotoDetailInteractor {
    
    func handle(request: PhotoDetailRequest) {
        switch request {
        case .viewDidLoad:
            presenter?.presentInitialize(photo: photo)
        }
    }
}
