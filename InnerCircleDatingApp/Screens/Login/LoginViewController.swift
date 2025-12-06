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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

    // MARK: - Actions
    @objc private func loginTapped() {
        Task {
            let result = await viewModel.login(
                email: emailTextField.text,
                password: passwordTextField.text
            )

            switch result {
            case .success:
                break
            case .failure(let error):
                showAlert(message: error.localizedDescription)
            }
        }
    }

    // MARK: - Helper Methods
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
