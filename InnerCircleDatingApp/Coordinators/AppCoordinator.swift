//
//  AppCoordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import UIKit

// MARK: - App Coordinator
final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    private let viewControllerFactory: ViewControllerFactoryProtocol

    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllerFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    func start() {
        navigate(to: .login)
    }

    // MARK: - Generic Navigation
    private func navigate(to destination: AppDestination) {
        switch destination {
        case .login:
            showLogin()
        case .onboarding(let email):
            showOnboarding(email: email)
        case .home(let email):
            showHome(email: email)
        }
    }

    // MARK: - Private Navigation Methods
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        addChildCoordinator(loginCoordinator)

        loginCoordinator.onFinish = { [weak self, weak loginCoordinator] destination in
            guard let self = self, let loginCoordinator = loginCoordinator else { return }
            self.removeChildCoordinator(loginCoordinator)
            self.navigate(to: destination)
        }

        loginCoordinator.start()
    }

    private func showOnboarding(email: String) {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController, email: email)
        addChildCoordinator(onboardingCoordinator)

        onboardingCoordinator.onFinish = { [weak self, weak onboardingCoordinator] destination in
            guard let self = self, let onboardingCoordinator = onboardingCoordinator else { return }
            self.removeChildCoordinator(onboardingCoordinator)
            self.navigate(to: destination)
        }

        onboardingCoordinator.onCancel = { [weak self] in
            guard let self = self else { return }
            self.removeAllChildCoordinators()
            self.navigationController.popToRootViewController(animated: true)
            self.navigate(to: .login)
        }

        onboardingCoordinator.start()
    }

    private func showHome(email: String) {
        navigationController.viewControllers.removeAll()

        let homeCoordinator = HomeCoordinator(
            navigationController: navigationController,
            email: email,
            viewControllerFactory: viewControllerFactory
        )
        addChildCoordinator(homeCoordinator)

        homeCoordinator.onFinish = { [weak self] destination in
            guard let self = self else { return }
            self.removeAllChildCoordinators()
            self.navigate(to: destination)
        }

        homeCoordinator.start()
    }
}
