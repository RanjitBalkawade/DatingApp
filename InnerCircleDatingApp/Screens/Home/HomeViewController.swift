//
//  HomeViewController.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    var viewModel: HomeViewModelProtocol!

    // MARK: - UI Components
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .systemPink
        return indicator
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadHomeData()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = AppTheme.Colors.background
        navigationItem.hidesBackButton = true

        setupLabels()
        setupButtons()
        setupConstraints()
    }

    private func setupLabels() {
        welcomeLabel.font = AppTheme.Fonts.largeTitle
        welcomeLabel.textColor = AppTheme.Colors.text

        subtitleLabel.font = AppTheme.Fonts.title3
        subtitleLabel.textColor = AppTheme.Colors.secondaryText
    }

    private func setupButtons() {
        profileButton.applyPrimaryStyle()
        logoutButton.applySecondaryStyle()

        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        contentStackView.addArrangedSubview(welcomeLabel)
        contentStackView.addArrangedSubview(subtitleLabel)

        view.addSubview(contentStackView)
        view.addSubview(profileButton)
        view.addSubview(logoutButton)
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppTheme.Spacing.xxl),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.xl),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.xl),

            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AppTheme.Spacing.xl),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.xl),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.xl),
            logoutButton.heightAnchor.constraint(equalToConstant: 54),

            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -AppTheme.Spacing.md),
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.xl),
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.xl),
            profileButton.heightAnchor.constraint(equalToConstant: 54),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            Task { @MainActor in
                self?.handleViewState(state)
            }
        }
    }

    // MARK: - View State Handling
    private func handleViewState(_ state: ViewState<User>) {
        switch state {
        case .idle:
            setLoading(false)
            contentStackView.isHidden = true

        case .loading:
            setLoading(true)
            contentStackView.isHidden = true

        case .success(let user):
            setLoading(false)
            contentStackView.isHidden = false
            configureContent(with: user)

        case .error(let error):
            setLoading(false)
            contentStackView.isHidden = true
            showAlert(message: error.localizedDescription)
        }
    }

    private func setLoading(_ isLoading: Bool) {
        profileButton.isEnabled = !isLoading
        logoutButton.isEnabled = !isLoading

        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }

    // MARK: - Configuration
    private func configureContent(with user: User) {
        welcomeLabel.text = "Hello! 👋\n\(user.email)"
        subtitleLabel.text = "Welcome to InnerCircle"
        profileButton.setTitle("View Profile", for: .normal)
        logoutButton.setTitle("Logout", for: .normal)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.viewModel.loadHomeData()
        })
        present(alert, animated: true)
    }

    @objc private func profileButtonTapped() {
        // TODO: Implement profile view navigation
        print("Profile button tapped")
    }

    @objc private func logoutButtonTapped() {
        viewModel.logout()
    }
}
