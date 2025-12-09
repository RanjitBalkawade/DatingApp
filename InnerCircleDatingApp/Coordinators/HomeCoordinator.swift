//
//  HomeCoordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

import UIKit

// MARK: - Home Coordinator Actions Protocol
protocol HomeCoordinatorActions: AnyObject {
    func didRequestLogout()
}

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let email: String

    var onFinish: ((AppDestination) -> Void)?

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

    func start() {
        showHomeScreen()
    }

    // MARK: - Private Methods
    private func showHomeScreen() {
        let homeVC = viewControllerFactory.makeHomeViewController(email: email, coordinator: self)
        navigationController.setViewControllers([homeVC], animated: true)
    }
}

// MARK: - Home Coordinator Actions
extension HomeCoordinator: HomeCoordinatorActions {
    func didRequestLogout() {
        onFinish?(.login)
    }
}
