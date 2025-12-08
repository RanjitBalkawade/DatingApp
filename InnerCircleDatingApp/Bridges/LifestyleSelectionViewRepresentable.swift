//
//  LifestyleSelectionViewRepresentable.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import SwiftUI
import UIKit

struct LifestyleSelectionViewRepresentable: UIViewControllerRepresentable {
    @Binding var selectedLifestyles: [LifestyleItem]

    func makeUIViewController(context: Context) -> LifestyleSelectionViewController {
        let viewController = LifestyleSelectionViewController()
        viewController.delegate = context.coordinator

        // Convert LifestyleItem to dictionaries for Objective-C
        let selectedDicts = selectedLifestyles.map { lifestyle -> [AnyHashable: Any] in
            return [
                "name": lifestyle.name,
                "detail": lifestyle.detail ?? NSNull()
            ]
        }
        viewController.selectedLifestyles = selectedDicts

        return viewController
    }

    func updateUIViewController(_ uiViewController: LifestyleSelectionViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(selectedLifestyles: $selectedLifestyles)
    }

    class Coordinator: NSObject, LifestyleSelectionDelegate {
        var selectedLifestyles: Binding<[LifestyleItem]>

        init(selectedLifestyles: Binding<[LifestyleItem]>) {
            self.selectedLifestyles = selectedLifestyles
        }

        func lifestyleSelectionViewController(_ controller: LifestyleSelectionViewController, didSelectLifestyles lifestyles: [[AnyHashable : Any]]) {
            // Convert dictionaries from Objective-C to LifestyleItem
            let lifestyleItems = lifestyles.compactMap { dict -> LifestyleItem? in
                guard let name = dict["name"] as? String else { return nil }
                let detail = dict["detail"] as? String
                return LifestyleItem(name: name, detail: detail)
            }

            selectedLifestyles.wrappedValue = lifestyleItems
        }
    }
}
