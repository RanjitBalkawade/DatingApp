//
//  LifestyleDetailCell.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import UIKit

@MainActor
protocol LifestyleDetailCellDelegate: AnyObject {
    func lifestyleDetailCell(_ cell: LifestyleDetailCell, didUpdateDetail detail: String, forLifestyle lifestyle: String)
}

class LifestyleDetailCell: UITableViewCell {

    weak var delegate: LifestyleDetailCellDelegate?
    private var lifestyleName: String = ""

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.body
        label.textColor = AppTheme.Colors.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let detailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add a note (optional)"
        textField.font = AppTheme.Fonts.callout
        textField.borderStyle = .roundedRect
        textField.backgroundColor = AppTheme.Colors.secondaryBackground
        textField.returnKeyType = .done
        textField.autocapitalizationType = .sentences
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = AppTheme.Colors.primary
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none

        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailTextField)

        NSLayoutConstraint.activate([
            checkmarkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkmarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),

            nameLabel.leadingAnchor.constraint(equalTo: checkmarkImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            detailTextField.leadingAnchor.constraint(equalTo: checkmarkImageView.trailingAnchor, constant: 12),
            detailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            detailTextField.heightAnchor.constraint(equalToConstant: 36),
            detailTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    private func setupActions() {
        detailTextField.delegate = self
        detailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    func configure(with lifestyle: String, detail: String?) {
        lifestyleName = lifestyle
        nameLabel.text = lifestyle
        detailTextField.text = detail
    }

    @objc private func textFieldDidChange() {
        let text = detailTextField.text ?? ""
        delegate?.lifestyleDetailCell(self, didUpdateDetail: text, forLifestyle: lifestyleName)
    }
}

extension LifestyleDetailCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

