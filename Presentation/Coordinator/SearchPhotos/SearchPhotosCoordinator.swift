//
//  SearchPhotosCoordinator.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import UIKit
import Domain

protocol SearchPhotosCoordinatorRouter: AnyObject {
    func searchPhotosDidComplete()
}

final class SearchPhotosCoordinator: Coordinatorable {
        
    private let navigationController: UINavigationController
    private weak var router: SearchPhotosCoordinatorRouter?
    private var childCoordinator: Coordinatorable?
    
    init(navigationController: UINavigationController, router: SearchPhotosCoordinatorRouter) {
        self.navigationController = navigationController
        self.router = router
    }

    func start() {
        let searchPhotosVC = SearchPhotosViewController(with: self)
        navigationController.pushViewController(searchPhotosVC, animated: true)
    }
}

// MARK: - SearchPhotosRouter
extension SearchPhotosCoordinator: SearchPhotosRouter {
    
    func searchPhotosDidTap(photo: Photo) {
        syncSafe {
            
        }
    }
}
