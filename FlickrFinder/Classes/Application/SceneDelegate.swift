//
//  SceneDelegate.swift
//  FlickrFinder
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import UIKit
import Presentation

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let coordinator = AppCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
