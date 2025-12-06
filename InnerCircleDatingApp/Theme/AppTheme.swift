//
//  AppTheme.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//

import UIKit
import SwiftUI

// MARK: - App Theme
struct AppTheme {

    // MARK: - Colors
    struct Colors {
        static let primary = UIColor.systemPink
        static let primarySwiftUI = Color.pink

        static let background = UIColor.systemBackground
        static let secondaryBackground = UIColor.secondarySystemBackground

        static let text = UIColor.label
        static let secondaryText = UIColor.secondaryLabel

        static let success = UIColor.systemGreen
        static let error = UIColor.systemRed
        static let warning = UIColor.systemOrange

        static let separator = UIColor.separator
        static let border = UIColor.systemGray4
    }

    // MARK: - Fonts
    struct Fonts {
        static let largeTitle = UIFont.systemFont(ofSize: 34, weight: .bold)
        static let title = UIFont.systemFont(ofSize: 28, weight: .bold)
        static let title2 = UIFont.systemFont(ofSize: 22, weight: .bold)
        static let title3 = UIFont.systemFont(ofSize: 20, weight: .semibold)

        static let headline = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let body = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let callout = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let subheadline = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let footnote = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let caption = UIFont.systemFont(ofSize: 12, weight: .regular)

        // SwiftUI Fonts
        static let largeTitleSwiftUI = Font.largeTitle.weight(.bold)
        static let titleSwiftUI = Font.title.weight(.bold)
        static let headlineSwiftUI = Font.headline
        static let bodySwiftUI = Font.body
    }

    // MARK: - Spacing
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 24
    }

    // MARK: - Border Width
    struct BorderWidth {
        static let thin: CGFloat = 1
        static let medium: CGFloat = 2
        static let thick: CGFloat = 3
    }
}

// MARK: - UIButton Extension
extension UIButton {

    func applyPrimaryStyle() {
        backgroundColor = AppTheme.Colors.primary
        setTitleColor(.white, for: .normal)
        titleLabel?.font = AppTheme.Fonts.headline
        layer.cornerRadius = AppTheme.CornerRadius.medium
        clipsToBounds = true
    }

    func applySecondaryStyle() {
        backgroundColor = .clear
        setTitleColor(AppTheme.Colors.primary, for: .normal)
        titleLabel?.font = AppTheme.Fonts.headline
        layer.cornerRadius = AppTheme.CornerRadius.medium
        layer.borderWidth = AppTheme.BorderWidth.medium
        layer.borderColor = AppTheme.Colors.primary.cgColor
        clipsToBounds = true
    }
}

// MARK: - UITextField Extension
extension UITextField {

    func applyStandardStyle() {
        font = AppTheme.Fonts.body
        borderStyle = .roundedRect
        backgroundColor = AppTheme.Colors.secondaryBackground
        textColor = AppTheme.Colors.text
        layer.cornerRadius = AppTheme.CornerRadius.small
    }
}

// MARK: - UILabel Extension
extension UILabel {

    func applyTitleStyle() {
        font = AppTheme.Fonts.title
        textColor = AppTheme.Colors.text
    }

    func applyHeadlineStyle() {
        font = AppTheme.Fonts.headline
        textColor = AppTheme.Colors.text
    }

    func applyBodyStyle() {
        font = AppTheme.Fonts.body
        textColor = AppTheme.Colors.text
    }

    func applySecondaryStyle() {
        font = AppTheme.Fonts.subheadline
        textColor = AppTheme.Colors.secondaryText
    }
}

// MARK: - UIView Extension
extension UIView {

    func applyShadowStyle() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
}
