//
//  LifestyleDetailViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import Foundation

// MARK: - Lifestyle Detail View Model Protocol
@MainActor
protocol LifestyleDetailViewModelProtocol {
    var lifestyleDetails: [LifestyleItem] { get set }
    var headerText: String { get }
    var subtitleText: String { get }

    func loadLifestyles(_ lifestyles: [LifestyleItem])
    func updateDetail(forLifestyleNamed name: String, detail: String)
    func getUpdatedLifestyles() -> [LifestyleItem]
}

// MARK: - Lifestyle Detail View Model
@MainActor
final class LifestyleDetailViewModel: LifestyleDetailViewModelProtocol {

    // MARK: - Properties
    var lifestyleDetails: [LifestyleItem] = []

    var headerText: String {
        return "Add Details"
    }

    var subtitleText: String {
        return "Add notes to your selected lifestyles (optional)"
    }

    weak var delegate: LifestyleDetailDelegate?

    // MARK: - Initialization
    init(selectedLifestyles: [LifestyleItem] = [], delegate: LifestyleDetailDelegate? = nil) {
        self.delegate = delegate
        loadLifestyles(selectedLifestyles)
    }

    // MARK: - Public Methods
    func loadLifestyles(_ lifestyles: [LifestyleItem]) {
        self.lifestyleDetails = lifestyles
    }

    func updateDetail(forLifestyleNamed name: String, detail: String) {
        if let index = lifestyleDetails.firstIndex(where: { $0.name == name }) {
            lifestyleDetails[index] = lifestyleDetails[index].with(detail: detail)
        }
    }

    func getUpdatedLifestyles() -> [LifestyleItem] {
        return lifestyleDetails
    }
}
