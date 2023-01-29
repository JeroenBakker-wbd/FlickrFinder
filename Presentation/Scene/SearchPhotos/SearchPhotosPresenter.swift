//
//  SearchPhotosPresenter.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain

final class SearchPhotosPresenter {
    
    // MARK: private properties
    private let loadingIdentifier: String = UUID().uuidString
    private weak var displayLogic: SearchPhotosDisplayLogic?
    
    func setup(with displayLogic: SearchPhotosDisplayLogic?) {
        self.displayLogic = displayLogic
    }
}

// MARK: - Responses
extension SearchPhotosPresenter {
    
    func presentInitialize() {
        displayLogic?.display(
            viewModel: SearchPhotosViewController.ViewModel(
                searchBarPlaceholder: "Search..."
            )
        )
    }
    
    func present(isLoading: Bool) {
        displayLogic?.display(isLoading: isLoading, item: .loading(loadingIdentifier))
    }
    
    func present(error: Error) {
        present(isLoading: false)
        
        displayLogic?.displayResult(items: [
            SearchPhotosItem.empty(SearchPhotosTitleCell.ViewModel(title: "Something went wrong, please try again"))
        ], isNewResult: true)
    }
    
    func present(photos: [Photo], isNewResult: Bool) {
        present(isLoading: false)
        
        if photos.isEmpty {
            displayLogic?.displayResult(items: [
                SearchPhotosItem.empty(SearchPhotosTitleCell.ViewModel(title: "No results found"))
            ], isNewResult: isNewResult)
        } else {
            displayLogic?.displayResult(items: photos.map({ photo in
                return SearchPhotosItem.results(SearchPhotosResultCell.ViewModel(
                    id: photo.id,
                    title: photo.title,
                    imageUrl: photo.thumbnailURL
                ))
            }), isNewResult: isNewResult)
        }
    }
    
    func presentClearResults() {
        displayLogic?.displayClearResults()
    }
}
