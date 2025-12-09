//
//  Coordinator.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import UIKit

// MARK: - Base Coordinator Protocol
@MainActor
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }

    func start()
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func removeAllChildCoordinators()
}

// MARK: - Default Implementations
@MainActor
extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}
