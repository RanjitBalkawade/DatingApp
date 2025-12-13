//
//  LifestyleSelectionViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import Foundation

// MARK: - Lifestyle Selection View Model
@objc
@MainActor
class LifestyleSelectionViewModel: NSObject {

    // MARK: - Properties

    /// Available lifestyle options
    @objc let availableLifestyles: [String] = [
        "Yoga",
        "Fitness",
        "Travel",
        "Cooking",
        "Reading",
        "Music",
        "Art",
        "Photography",
        "Gaming",
        "Hiking",
        "Dancing",
        "Movies"
    ]

    /// Internal storage as dictionaries for Objective-C compatibility
    private var selectedLifestyleDicts: [[String: Any]] = []

    // MARK: - Initialization

    @objc override init() {
        super.init()
    }

    // MARK: - Public Methods (Objective-C Compatible)

    /// Load selected lifestyles from dictionaries
    @objc func loadSelectedLifestyles(_ lifestyles: [[String: Any]]) {
        self.selectedLifestyleDicts = lifestyles
    }

    /// Toggle selection of a lifestyle by name
    @objc func toggleLifestyle(_ name: String) {
        if let index = selectedLifestyleDicts.firstIndex(where: {
            ($0["name"] as? String) == name
        }) {
            selectedLifestyleDicts.remove(at: index)
        } else {
            selectedLifestyleDicts.append([
                "name": name,
                "detail": NSNull()
            ])
        }
    }

    /// Check if a lifestyle is currently selected
    @objc func isSelected(_ name: String) -> Bool {
        return selectedLifestyleDicts.contains(where: {
            ($0["name"] as? String) == name
        })
    }

    /// Get all selected lifestyles as dictionaries
    @objc func getSelectedLifestyles() -> [[String: Any]] {
        return selectedLifestyleDicts
    }
}
