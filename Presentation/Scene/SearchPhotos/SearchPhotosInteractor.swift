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
    case didScrollFarEnoughForNextBatch
}

final class SearchPhotosInteractor {
    
    @Injected(Container.Workers.searchPhotos) private var searchPhotosWorker
    
    @ThreadSafe private var currentResult: SearchPhotosResult?
    @ThreadSafe private var isPerformingNextBatch: Bool = false
    @ThreadSafe private var didReachEnd: Bool = false
    
    private var currentSearchTerm: String = ""
    private var currentSearchTask: Task<Void, Never>?
    
    private var presenter: SearchPhotosPresenter?
    private var router: SearchPhotosRouter?
    
    // MARK: Lifecycle
    init() { }
    
    // MARK: Internal methods
    func setup(with presenter: SearchPhotosPresenter, router: SearchPhotosRouter) {
        self.presenter = presenter
        self.router = router
    }
}

// MARK: - Requests
extension SearchPhotosInteractor {
    
    func handle(request: SearchPhotosRequest) {
        switch request {
        case .viewDidLoad:
            presenter?.presentInitialize()
        case .searchBarTextDidChange(let text):
            performSearch(with: text, isNextBatch: false)
        case .didTapItem(let id):
            guard let photo = currentResult?.photos.first(where: { $0.id == id }) else {
                assertionFailure("Received an ID which does not excist \(id)")
                return
            }
            
            router?.searchPhotosDidTap(photo: photo)
        case .didScrollFarEnoughForNextBatch:
            guard !isPerformingNextBatch && !didReachEnd else { return }

            isPerformingNextBatch = true
            performSearch(with: currentSearchTerm, isNextBatch: true)
        }
    }
}

// MARK: - Handle
private extension SearchPhotosInteractor {
    
    func performSearch(with searchTerm: String, isNextBatch: Bool) {
        guard !searchTerm.isEmpty else {
            didReachEnd = true
            isPerformingNextBatch = false
            presenter?.presentClearResults()
            return
        }
        
        didReachEnd = false
        currentSearchTerm = searchTerm
        currentSearchTask?.cancel()
        currentSearchTask = Task { [weak self] in
            do {
                try await Task.sleep(seconds: 0.35)
                self?.presenter?.present(isLoading: true)

                let currentResult = self?.currentResult
                
                var offset = currentResult?.offset ?? 1
                if isNextBatch {
                    offset += 1
                }
                let limit = currentResult?.limit ?? 25
                
                var newResult = try await self?.searchPhotosWorker?.invoke(with: searchTerm, offset: offset, limit: limit)
                self?.presenter?.present(photos: newResult?.photos ?? [], isNewResult: isNextBatch == false)
                
                if isNextBatch {
                    newResult?.insert(photos: currentResult?.photos ?? [], at: 0)
                }
                self?.currentResult = newResult
                self?.didReachEnd = newResult?.totalPhotos == newResult?.photos.count
                self?.isPerformingNextBatch = false
            } catch let error {
                if Task.isCancelled {
                    self?.presenter?.present(isLoading: false)
                } else {
                    self?.didReachEnd = true // don't execute again, we received an error
                    self?.isPerformingNextBatch = false
                    self?.presenter?.present(error: error)
                }
            }
        }
    }
}
