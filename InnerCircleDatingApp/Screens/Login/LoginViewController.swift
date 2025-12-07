//
//  LoginViewController.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    var viewModel: LoginViewModelProtocol!

    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var hintLabel: UILabel!

    private var loadingIndicator: UIActivityIndicatorView?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLoadingIndicator()
        bindViewModel()
    }

    // MARK: - Setup
    private func setupUI() {
        emailTextField.applyStandardStyle()
        passwordTextField.applyStandardStyle()
        loginButton.applyPrimaryStyle()
        logoLabel.applyTitleStyle()
        subtitleLabel.applyBodyStyle()
        hintLabel.applySecondaryStyle()
    }

    private func setupLoadingIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .systemPink
        view.addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        loadingIndicator = indicator
    }

    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            Task { @MainActor in
                self?.handleViewState(state)
            }
        }
    }

    // MARK: - Actions
    @objc private func loginTapped() {
        Task {
            await viewModel.login(
                email: emailTextField.text,
                password: passwordTextField.text
            )
        }
    }

    // MARK: - Helper Methods
    private func handleViewState(_ state: ViewState<(UserType, String)>) {
        switch state {
        case .idle:
            setLoading(false)

        case .loading:
            setLoading(true)

        case .success:
            setLoading(false)

        case .error(let error):
            setLoading(false)
            showAlert(message: error.localizedDescription)
        }
    }

    private func setLoading(_ isLoading: Bool) {
        loginButton.isEnabled = !isLoading
        emailTextField.isEnabled = !isLoading
        passwordTextField.isEnabled = !isLoading

        if isLoading {
            loadingIndicator?.startAnimating()
        } else {
            loadingIndicator?.stopAnimating()
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
