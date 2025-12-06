//
//  LoginCoordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import UIKit

class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: AppCoordinator?

    private let viewControllerFactory: ViewControllerFactoryProtocol

    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    convenience init(navigationController: UINavigationController) {
        self.init(navigationController: navigationController, viewControllerFactory: ViewControllerFactory())
    }

    func start() {
        let loginVC = viewControllerFactory.makeLoginViewController(coordinator: self)
        navigationController.setViewControllers([loginVC], animated: false)
    }

    func didLogin(userType: UserType, email: String) {
        parentCoordinator?.loginDidComplete(userType: userType, email: email)
    }
}
