//
//  SearchPhotosInteractor.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain

enum SearchPhotosRequest {
    case viewDidLoad
}

final class SearchPhotosInteractor {
    
    // MARK: Private properties
    private var presenter: SearchPhotosPresenter?
    
    // MARK: Lifecycle
    init() { }
    
    // MARK: Internal methods
    func setup(with presenter: SearchPhotosPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Requests
extension SearchPhotosInteractor {
    
    func handle(request: SearchPhotosRequest) {
        switch request {
        case .viewDidLoad:
            break
        }
    }
}
