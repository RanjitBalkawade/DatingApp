//
//  SceneDelegate.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    // MARK: - Composition Root

    private lazy var serviceFactory: ServiceFactoryProtocol = {
        return ServiceFactory()
    }()

    private lazy var dependencyContainer: DependencyContainer = {
        return DependencyContainer(serviceFactory: serviceFactory)
    }()

    private lazy var viewControllerFactory: ViewControllerFactoryProtocol = {
        return ViewControllerFactory(dependencyContainer: dependencyContainer)
    }()

    // MARK: - Scene Lifecycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = false

        appCoordinator = AppCoordinator(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )

        appCoordinator?.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

