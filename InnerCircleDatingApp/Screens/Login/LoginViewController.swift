//
//  LoginViewController.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import UIKit

class LoginViewController: UIViewController {

    weak var coordinator: LoginCoordinator?
    var authService: AuthenticationServiceProtocol!

    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var hintLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc private func loginTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password")
            return
        }

        Task {
            do {
                let userType = try await authService.login(email: email, password: password)
                coordinator?.didLogin(userType: userType, email: email)
            } catch {
                showAlert(message: error.localizedDescription)
            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
