//
//  LifestyleSelectionViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import Foundation

// MARK: - Lifestyle Selection View Model Protocol
@MainActor
protocol LifestyleSelectionViewModelProtocol {
    var availableLifestyles: [String] { get }
    var selectedLifestyles: [LifestyleItem] { get set }

    func toggleLifestyle(_ name: String)
    func isSelected(_ name: String) -> Bool
    func getSelectedLifestyles() -> [LifestyleItem]
    func loadSelectedLifestyles(_ lifestyles: [LifestyleItem])
}

// MARK: - Lifestyle Selection View Model
@MainActor
final class LifestyleSelectionViewModel: LifestyleSelectionViewModelProtocol {

    // MARK: - Properties
    let availableLifestyles: [String] = [
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

    var selectedLifestyles: [LifestyleItem] = []

    // MARK: - Public Methods
    func toggleLifestyle(_ name: String) {
        if let index = selectedLifestyles.firstIndex(where: { $0.name == name }) {
            selectedLifestyles.remove(at: index)
        } else {
            selectedLifestyles.append(LifestyleItem(name: name, detail: nil))
        }
    }

    func isSelected(_ name: String) -> Bool {
        return selectedLifestyles.contains(where: { $0.name == name })
    }

    func getSelectedLifestyles() -> [LifestyleItem] {
        return selectedLifestyles
    }

    func loadSelectedLifestyles(_ lifestyles: [LifestyleItem]) {
        self.selectedLifestyles = lifestyles
    }
}

