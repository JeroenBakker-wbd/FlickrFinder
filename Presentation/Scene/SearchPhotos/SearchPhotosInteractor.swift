//
//  SearchPhotosInteractor.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Domain
import Factory

enum SearchPhotosRequest {
    case viewDidLoad
    case searchBarTextDidChange(text: String)
    case didTapItem(id: String)
}

final class SearchPhotosInteractor {
    
    @Injected(Container.Workers.searchPhotos) private var searchPhotosWorker
    
    @ThreadSafe private var currentResult: SearchPhotosResult?
    private var currentSearchTask: Task<Void, Never>?
    
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
        case .searchBarTextDidChange(let text):
            performSearch(with: text)
        case .didTapItem(let id):
            debugPrint(id)
        }
    }
}

// MARK: - Handle
private extension SearchPhotosInteractor {
    
    func performSearch(with searchTerm: String) {
        currentSearchTask?.cancel()
        currentSearchTask = Task { [weak self] in
            do {
                try await Task.sleep(seconds: 0.3)
                presenter?.present(isLoading: true)
                
                let currentResult = self?.currentResult
                
                let offset = currentResult?.offset ?? 1
                let limit = currentResult?.limit ?? 25
                
                let newResult = try await self?.searchPhotosWorker?.invoke(with: searchTerm, offset: offset, limit: limit)
                self?.currentResult = newResult
                debugPrint(newResult)
            } catch let error {
                if Task.isCancelled {
                    presenter?.present(isLoading: false)
                } else {
                    presenter?.present(error: error)
                }
            }
        }
    }
}
