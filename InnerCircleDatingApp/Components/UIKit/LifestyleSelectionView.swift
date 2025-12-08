//
//  LifestyleSelectionView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import UIKit

// MARK: - Lifestyle Selection View Delegate
@MainActor
protocol LifestyleSelectionViewDelegate: AnyObject {
    func lifestyleSelectionView(_ view: LifestyleSelectionView, didSelectLifestyles lifestyles: [LifestyleItem])
}

// MARK: - Lifestyle Selection View
@MainActor
final class LifestyleSelectionView: UIView {

    // MARK: - Properties
    weak var delegate: LifestyleSelectionViewDelegate?
    private let viewModel: LifestyleSelectionViewModelProtocol

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "LifestyleCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Initialization
    init(
        viewModel: LifestyleSelectionViewModelProtocol,
        selectedLifestyles: [LifestyleItem] = []
    ) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.loadSelectedLifestyles(selectedLifestyles)
        setupUI()
    }

    convenience init(selectedLifestyles: [LifestyleItem] = []) {
        let viewModel = LifestyleSelectionViewModel()
        self.init(viewModel: viewModel, selectedLifestyles: selectedLifestyles)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupUI() {
        backgroundColor = AppTheme.Colors.background

        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Public Methods
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension LifestyleSelectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.availableLifestyles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LifestyleCell", for: indexPath)

        let lifestyle = viewModel.availableLifestyles[indexPath.row]
        cell.textLabel?.text = lifestyle
        cell.textLabel?.font = AppTheme.Fonts.body
        cell.textLabel?.textColor = AppTheme.Colors.text

        if viewModel.isSelected(lifestyle) {
            cell.accessoryType = .checkmark
            cell.tintColor = AppTheme.Colors.primary
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension LifestyleSelectionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let lifestyle = viewModel.availableLifestyles[indexPath.row]
        viewModel.toggleLifestyle(lifestyle)

        tableView.reloadRows(at: [indexPath], with: .automatic)

        delegate?.lifestyleSelectionView(self, didSelectLifestyles: viewModel.getSelectedLifestyles())
    }
}

