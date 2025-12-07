//
//  OnboardingCoordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import UIKit
import SwiftUI

class OnboardingCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: AppCoordinator?
    let email: String

    init(navigationController: UINavigationController, email: String) {
        self.navigationController = navigationController
        self.email = email
    }

    func start() {
        let viewModel = OnboardingViewModel(email: email, coordinator: self)
        let onboardingView = OnboardingContainerView(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: onboardingView)
        hostingController.navigationItem.hidesBackButton = true

        navigationController.pushViewController(hostingController, animated: true)
    }

    func didCancelOnboarding() {
        parentCoordinator?.onboardingDidCancel()
    }
}

