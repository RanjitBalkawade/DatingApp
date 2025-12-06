//
//  ViewControllerFactory.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

import Foundation

import UIKit

// MARK: - View Controller Factory Protocol
@MainActor
protocol ViewControllerFactoryProtocol {
    func makeLoginViewController(coordinator: LoginCoordinator) -> LoginViewController
    func makeHomeViewController(email: String) -> HomeViewController
}

// MARK: - Default View Controller Factory
@MainActor
final class ViewControllerFactory: ViewControllerFactoryProtocol {

    private let dependencyContainer: DependencyContainer

    init(dependencyContainer: DependencyContainer = .shared) {
        self.dependencyContainer = dependencyContainer
    }

    // MARK: - Factory Methods

    func makeLoginViewController(coordinator: LoginCoordinator) -> LoginViewController {
        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let viewModel = LoginViewModel(
            authService: dependencyContainer.authenticationService,
            coordinator: coordinator
        )
        viewController.viewModel = viewModel
        return viewController
    }

    func makeHomeViewController(email: String) -> HomeViewController {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(email: email)
        viewController.viewModel = viewModel
        return viewController
    }

}
