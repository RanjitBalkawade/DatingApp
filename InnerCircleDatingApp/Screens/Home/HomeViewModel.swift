//
//  HomeViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//


import Foundation

@MainActor
protocol HomeViewModelProtocol: AnyObject {
    var coordinator: HomeCoordinatorActions? { get set }
    var onStateChange: ((ViewState<User>) -> Void)? { get set }

    func loadHomeData()
    func logout()
}

@MainActor
final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Properties
    weak var coordinator: HomeCoordinatorActions?
    private let email: String
    private let userService: UserServiceProtocol

    var onStateChange: ((ViewState<User>) -> Void)?
    private var viewState: ViewState<User> = .idle {
        didSet {
            onStateChange?(viewState)
        }
    }

    // MARK: - Initialization
    init(
        email: String,
        userService: UserServiceProtocol,
        coordinator: HomeCoordinatorActions? = nil
    ) {
        self.email = email
        self.userService = userService
        self.coordinator = coordinator
    }

    // MARK: - Data Loading
    func loadHomeData() {
        Task {
            viewState = .loading

            do {
                let userDTO = try await userService.fetchUserProfile(for: email)
                let user = userDTO.toUser() // Map DTO to domain model
                viewState = .success(user)
            } catch {
                viewState = .error(error)
            }
        }
    }

    // MARK: - Actions
    func logout() {
        coordinator?.didRequestLogout()
    }
}
