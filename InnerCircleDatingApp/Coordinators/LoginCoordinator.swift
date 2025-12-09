//
//  LoginCoordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import UIKit

// MARK: - Login Coordinator Actions Protocol
protocol LoginCoordinatorActions: AnyObject {
    func didCompleteLogin(userType: UserType, email: String)
}

final class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var onFinish: ((AppDestination) -> Void)?

    private let viewControllerFactory: ViewControllerFactoryProtocol

    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    func start() {
        showLoginScreen()
    }

    // MARK: - Private Methods
    private func showLoginScreen() {
        let loginVC = viewControllerFactory.makeLoginViewController(coordinator: self)
        navigationController.setViewControllers([loginVC], animated: false)
    }
}

// MARK: - Login Coordinator Actions
extension LoginCoordinator: LoginCoordinatorActions {
    func didCompleteLogin(userType: UserType, email: String) {
        let destination: AppDestination = userType == .approved
            ? .home(email: email)
            : .onboarding(email: email)

        onFinish?(destination)
    }
}
