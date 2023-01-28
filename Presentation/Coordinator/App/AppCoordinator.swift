//
//  AppCoordinator.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import UIKit

public final class AppCoordinator: Coordinatorable {
    
    private let navigationController: UINavigationController
    private var childCoordinator: Coordinatorable?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        // as we do not use a launch setup nor we require login, we'll start our search coordinator
        childCoordinator = SearchPhotosCoordinator(
            navigationController: navigationController,
            router: self
        )
        childCoordinator?.start()
    }
}

// MARK: - SearchPhotosCoordinatorRouter
extension AppCoordinator: SearchPhotosCoordinatorRouter {
    
    func searchPhotosDidComplete() {
        // this way we can cleanup this coordinator and start a new one if needed
    }
}
