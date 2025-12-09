//
//  OnboardingCoordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import UIKit
import SwiftUI

// MARK: - Onboarding Coordinator Actions Protocol
protocol OnboardingCoordinatorActions: AnyObject {
    func didCompleteOnboarding(user: User)
    func didCancelOnboarding()
}

class OnboardingCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let email: String

    var onFinish: ((AppDestination) -> Void)?
    var onCancel: (() -> Void)?

    init(navigationController: UINavigationController, email: String) {
        self.navigationController = navigationController
        self.email = email
    }

    func start() {
        showOnboardingFlow()
    }

    // MARK: - Private Methods
    private func showOnboardingFlow() {
        let viewModel = OnboardingViewModel(email: email, coordinator: self)
        let onboardingView = OnboardingContainerView(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: onboardingView)
        hostingController.navigationItem.hidesBackButton = true

        navigationController.pushViewController(hostingController, animated: true)
    }
}

// MARK: - Onboarding Coordinator Actions
extension OnboardingCoordinator: OnboardingCoordinatorActions {
    func didCompleteOnboarding(user: User) {
        onFinish?(.home(email: user.email))
    }

    func didCancelOnboarding() {
        onCancel?()
    }
}
