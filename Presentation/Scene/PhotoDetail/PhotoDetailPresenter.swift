//
//  PhotoDetailPresenter.swift
//  Presentation
//
//  Created by Jeroen Bakker on 29/01/2023.
//

import Domain

final class PhotoDetailPresenter {
    
    // MARK: private properties
    private weak var displayLogic: PhotoDetailDisplayLogic?
    
    func setup(with displayLogic: PhotoDetailDisplayLogic?) {
        self.displayLogic = displayLogic
    }
}

// MARK: - Responses
extension PhotoDetailPresenter {
    
    func presentInitialize(photo: Photo) {
        displayLogic?.display(
            viewModel: PhotoDetailViewController.ViewModel(
                imageURL: photo.imageURL ?? photo.thumbnailURL
            )
        )
    }
}
