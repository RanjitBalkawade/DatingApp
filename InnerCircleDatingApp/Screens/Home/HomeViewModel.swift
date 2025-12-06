//
//  HomeViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

import Foundation

// MARK: - Home View Model Protocol
@MainActor
protocol HomeViewModelProtocol {
    var coordinator: HomeCoordinator? { get set }
    var email: String { get }
    var welcomeMessage: String { get }
    var subtitleMessage: String { get }
    var cardTitle: String { get }
    var profileButtonTitle: String { get }
    var logoutButtonTitle: String { get }

    func logout()
}

// MARK: - Home View Model
@MainActor
final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Properties
    weak var coordinator: HomeCoordinator?
    let email: String

    var welcomeMessage: String {
        return "Hello! 👋\n\(email)"
    }

    var subtitleMessage: String {
        return "Welcome to InnerCircle"
    }

    var cardTitle: String {
        return "Start Discovering Matches"
    }

    var profileButtonTitle: String {
        return "View Profile"
    }

    var logoutButtonTitle: String {
        return "Logout"
    }

    // MARK: - Initialization
    init(email: String, coordinator: HomeCoordinator? = nil) {
        self.email = email
        self.coordinator = coordinator
    }

    // MARK: - Actions
    func logout() {
        coordinator?.logout()
    }
}
