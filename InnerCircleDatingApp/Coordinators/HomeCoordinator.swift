//
//  HomeCoordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let email: String

    private let viewControllerFactory: ViewControllerFactoryProtocol

    init(
        navigationController: UINavigationController,
        email: String,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.email = email
        self.viewControllerFactory = viewControllerFactory
    }

    convenience init(navigationController: UINavigationController, email: String) {
        self.init(navigationController: navigationController, email: email, viewControllerFactory: ViewControllerFactory())
    }

    func start() {
        let homeVC = viewControllerFactory.makeHomeViewController(email: email)
        navigationController.setViewControllers([homeVC], animated: true)
    }
}

