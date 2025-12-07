//
//  LoginViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

import Foundation

// MARK: - Login View Model Protocol
@MainActor
protocol LoginViewModelProtocol: AnyObject {
    var coordinator: LoginCoordinator? { get set }
    var onStateChange: ((ViewState<(UserType, String)>) -> Void)? { get set }
    func login(email: String?, password: String?) async
    func validateEmail(_ email: String?) -> Bool
    func validatePassword(_ password: String?) -> Bool
}

// MARK: - Login Error
enum LoginError: LocalizedError {
    case emptyEmail
    case emptyPassword
    case authenticationFailed(Error)

    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Please enter your email"
        case .emptyPassword:
            return "Please enter your password"
        case .authenticationFailed(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - Login View Model
@MainActor
final class LoginViewModel: LoginViewModelProtocol {

    // MARK: - Properties
    weak var coordinator: LoginCoordinator?
    private let authService: AuthenticationServiceProtocol

    var onStateChange: ((ViewState<(UserType, String)>) -> Void)?
    private var viewState: ViewState<(UserType, String)> = .idle {
        didSet {
            onStateChange?(viewState)
        }
    }

    // MARK: - Initialization
    init(
        authService: AuthenticationServiceProtocol,
        coordinator: LoginCoordinator? = nil
    ) {
        self.authService = authService
        self.coordinator = coordinator
    }

    // MARK: - Public Methods
    func login(email: String?, password: String?) async {
        guard validateEmail(email), let validEmail = email else {
            viewState = .error(LoginError.emptyEmail)
            return
        }

        guard validatePassword(password) else {
            viewState = .error(LoginError.emptyPassword)
            return
        }

        viewState = .loading

        do {
            let userType = try await authService.login(email: validEmail, password: password!)
            viewState = .success((userType, validEmail))
            coordinator?.didLogin(userType: userType, email: validEmail)
        } catch {
            viewState = .error(LoginError.authenticationFailed(error))
        }
    }

    func validateEmail(_ email: String?) -> Bool {
        guard let email = email, !email.isEmpty else {
            return false
        }
        return true
    }

    func validatePassword(_ password: String?) -> Bool {
        guard let password = password, !password.isEmpty else {
            return false
        }
        return true
    }
}
