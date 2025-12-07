//
//  HomeViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

// MARK: - Home View Model Protocol
@MainActor
protocol HomeViewModelProtocol: AnyObject {
    var coordinator: HomeCoordinator? { get set }
    var onStateChange: ((ViewState<User>) -> Void)? { get set }

    func loadHomeData()
    func logout()
}

// MARK: - Home View Model
@MainActor
final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Properties
    weak var coordinator: HomeCoordinator?
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
        coordinator: HomeCoordinator? = nil
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
        coordinator?.logout()
    }
}
