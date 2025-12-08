//
//  LifestyleDetailView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import UIKit

// MARK: - Lifestyle Detail View Delegate
@MainActor
protocol LifestyleDetailViewDelegate: AnyObject {
    func lifestyleDetailView(_ view: LifestyleDetailView, didUpdateLifestyles lifestyles: [LifestyleItem])
}

// MARK: - Lifestyle Detail View
@MainActor
final class LifestyleDetailView: UIView {

    // MARK: - Properties
    weak var delegate: LifestyleDetailViewDelegate?
    private let viewModel: LifestyleDetailViewModelProtocol

    // MARK: - UI Components
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .singleLine
        table.keyboardDismissMode = .interactive
        table.register(LifestyleDetailCell.self, forCellReuseIdentifier: "LifestyleDetailCell")
        table.estimatedRowHeight = 120
        table.rowHeight = UITableView.automaticDimension
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initialization
    init(
        viewModel: LifestyleDetailViewModelProtocol,
        selectedLifestyles: [LifestyleItem] = []
    ) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.loadLifestyles(selectedLifestyles)
        setupUI()
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupUI() {
        backgroundColor = AppTheme.Colors.background

        headerLabel.applyTitleStyle()
        subtitleLabel.applySecondaryStyle()
        doneButton.applyPrimaryStyle()

        addSubview(headerLabel)
        addSubview(subtitleLabel)
        addSubview(tableView)
        addSubview(doneButton)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: AppTheme.Spacing.md),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppTheme.Spacing.md),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppTheme.Spacing.md),

            subtitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: AppTheme.Spacing.sm),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppTheme.Spacing.xl),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppTheme.Spacing.xl),

            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: AppTheme.Spacing.md),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -AppTheme.Spacing.md),

            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppTheme.Spacing.xl),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppTheme.Spacing.xl),
            doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -AppTheme.Spacing.md),
            doneButton.heightAnchor.constraint(equalToConstant: 54)
        ])

        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }

    private func configureContent() {
        headerLabel.text = viewModel.headerText
        subtitleLabel.text = viewModel.subtitleText
        doneButton.setTitle(viewModel.doneButtonTitle, for: .normal)
    }

    // MARK: - Actions
    @objc private func doneTapped() {
        dismissKeyboard()
        let updatedLifestyles = viewModel.getUpdatedLifestyles()
        delegate?.lifestyleDetailView(self, didUpdateLifestyles: updatedLifestyles)
    }

    @objc private func dismissKeyboard() {
        endEditing(true)
    }

    // MARK: - Public Methods
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension LifestyleDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lifestyleDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LifestyleDetailCell", for: indexPath) as? LifestyleDetailCell else {
            return UITableViewCell()
        }

        let lifestyle = viewModel.lifestyleDetails[indexPath.row]
        cell.configure(with: lifestyle.name, detail: lifestyle.detail)
        cell.delegate = self

        return cell
    }
}

// MARK: - UITableViewDelegate
extension LifestyleDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Lifestyle Detail Cell Delegate
extension LifestyleDetailView: LifestyleDetailCellDelegate {
    func lifestyleDetailCell(_ cell: LifestyleDetailCell, didUpdateDetail detail: String, forLifestyle lifestyle: String) {
        viewModel.updateDetail(forLifestyleNamed: lifestyle, detail: detail)
    }
}

