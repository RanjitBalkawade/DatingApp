//
//  LifestyleDetailViewController.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import UIKit

protocol LifestyleDetailDelegate: AnyObject {
    func lifestyleDetailViewController(_ controller: LifestyleDetailViewController,
                                       didUpdateLifestyles lifestyles: [LifestyleItem])
}

class LifestyleDetailViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: LifestyleDetailDelegate?
    private let viewModel: LifestyleDetailViewModelProtocol
    var selectedLifestyles: [LifestyleItem] = []

    // MARK: - Initialization
    init(viewModel: LifestyleDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .singleLine
        table.keyboardDismissMode = .interactive
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupActions()
        configureContent()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = AppTheme.Colors.background

        headerLabel.applyTitleStyle()
        subtitleLabel.applySecondaryStyle()

        view.addSubview(headerLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppTheme.Spacing.md),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.md),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.md),

            subtitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: AppTheme.Spacing.sm),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.xl),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.xl),

            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: AppTheme.Spacing.md),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AppTheme.Spacing.md)
        ])
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LifestyleDetailCell.self, forCellReuseIdentifier: "LifestyleDetailCell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func configureContent() {
        headerLabel.text = viewModel.headerText
        subtitleLabel.text = viewModel.subtitleText
        viewModel.loadLifestyles(selectedLifestyles)
        tableView.reloadData()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LifestyleDetailViewController: UITableViewDataSource {
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

extension LifestyleDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LifestyleDetailViewController: LifestyleDetailCellDelegate {
    func lifestyleDetailCell(_ cell: LifestyleDetailCell, didUpdateDetail detail: String, forLifestyle lifestyle: String) {
        viewModel.updateDetail(forLifestyleNamed: lifestyle, detail: detail)
        
        let updatedLifestyles = viewModel.getUpdatedLifestyles()
        delegate?.lifestyleDetailViewController(self, didUpdateLifestyles: updatedLifestyles)
    }
}
