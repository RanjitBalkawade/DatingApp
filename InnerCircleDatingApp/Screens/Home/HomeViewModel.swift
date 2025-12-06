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
    var email: String { get }
    var welcomeMessage: String { get }
    var subtitleMessage: String { get }
    var cardTitle: String { get }
    var profileButtonTitle: String { get }
}

// MARK: - Home View Model
@MainActor
final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Properties
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

    // MARK: - Initialization
    init(email: String) {
        self.email = email
    }
}
