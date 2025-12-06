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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureContent()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = AppTheme.Colors.background
        navigationItem.hidesBackButton = true

        setupLabels()
        setupButton()
        setupConstraints()
    }

    private func setupLabels() {
        welcomeLabel.font = AppTheme.Fonts.largeTitle
        welcomeLabel.textColor = AppTheme.Colors.text

        subtitleLabel.font = AppTheme.Fonts.title3
        subtitleLabel.textColor = AppTheme.Colors.secondaryText
    }

    private func setupButton() {
        profileButton.applyPrimaryStyle()
        logoutButton.applySecondaryStyle()

        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        view.addSubview(welcomeLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(profileButton)
        view.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppTheme.Spacing.xxl),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.xl),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.xl),

            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: AppTheme.Spacing.sm),

            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AppTheme.Spacing.xl),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.xl),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.xl),
            logoutButton.heightAnchor.constraint(equalToConstant: 54),

            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -AppTheme.Spacing.md),
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.xl),
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.xl),
            profileButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    // MARK: - Configuration
    private func configureContent() {
        welcomeLabel.text = viewModel.welcomeMessage
        subtitleLabel.text = viewModel.subtitleMessage
        profileButton.setTitle(viewModel.profileButtonTitle, for: .normal)
        logoutButton.setTitle(viewModel.logoutButtonTitle, for: .normal)
    }

    @objc private func logoutButtonTapped() {
        viewModel.logout()
    }
}
