//
//  AppCoordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLogin()
    }

    func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.parentCoordinator = self
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }

    func loginDidComplete(userType: UserType, email: String) {
        switch userType {
        case .approved:
            showHome(email: email)
        case .new:
            showOnboarding(email: email)
        }
    }
    
    func showOnboarding(email: String) {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController, email: email)
        onboardingCoordinator.parentCoordinator = self
        childCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.start()
    }

    func onboardingDidCancel() {
        childCoordinators.removeAll()
        navigationController.popToRootViewController(animated: true)
        showLogin()
    }

    func showHome(email: String) {
        navigationController.viewControllers.removeAll()

        let homeCoordinator = HomeCoordinator(navigationController: navigationController, email: email)
        homeCoordinator.parentCoordinator = self
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }

    func logout() {
        childCoordinators.removeAll()
        showLogin()
    }
}
