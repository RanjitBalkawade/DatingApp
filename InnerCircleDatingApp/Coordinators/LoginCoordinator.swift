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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginVC.coordinator = self
        loginVC.authService = AuthenticationService()
        navigationController.setViewControllers([loginVC], animated: false)
    }


    func didLogin(userType: UserType, email: String) {
        parentCoordinator?.loginDidComplete(userType: userType, email: email)
    }
}
