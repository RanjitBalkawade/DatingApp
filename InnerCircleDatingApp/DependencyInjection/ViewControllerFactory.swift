//
//  ViewControllerFactory.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

import UIKit

// MARK: - View Controller Factory Protocol
@MainActor
protocol ViewControllerFactoryProtocol {
    func makeLoginViewController(coordinator: LoginCoordinatorActions) -> LoginViewController
    func makeHomeViewController(email: String, coordinator: HomeCoordinatorActions) -> HomeViewController
    func makeLifestyleDetailViewController(
        selectedLifestyles: [LifestyleItem],
        delegate: LifestyleDetailDelegate?
    ) -> LifestyleDetailViewController
}

// MARK: - Default View Controller Factory
@MainActor
final class ViewControllerFactory: ViewControllerFactoryProtocol {

    private let dependencyContainer: DependencyContainer

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }

    // MARK: - Factory Methods

    func makeLoginViewController(coordinator: LoginCoordinatorActions) -> LoginViewController {
        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let viewModel = LoginViewModel(
            authService: dependencyContainer.authenticationService,
            coordinator: coordinator
        )
        viewController.viewModel = viewModel
        return viewController
    }

    func makeHomeViewController(email: String, coordinator: HomeCoordinatorActions) -> HomeViewController {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(
            email: email,
            userService: dependencyContainer.userService,
            coordinator: coordinator
        )
        viewController.viewModel = viewModel
        return viewController
    }

    func makeLifestyleDetailViewController(
        selectedLifestyles: [LifestyleItem],
        delegate: LifestyleDetailDelegate?
    ) -> LifestyleDetailViewController {
        let viewModel = LifestyleDetailViewModel(
            selectedLifestyles: selectedLifestyles,
            delegate: delegate
        )
        let viewController = LifestyleDetailViewController(viewModel: viewModel)
        viewController.selectedLifestyles = selectedLifestyles
        viewController.delegate = delegate
        return viewController
    }
}
