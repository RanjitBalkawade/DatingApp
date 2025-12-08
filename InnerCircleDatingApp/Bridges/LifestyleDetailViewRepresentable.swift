//
//  LifestyleDetailViewRepresentable.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import SwiftUI
import UIKit

struct LifestyleDetailViewRepresentable: UIViewControllerRepresentable {
    @Binding var selectedLifestyles: [LifestyleItem]

    func makeUIViewController(context: Context) -> LifestyleDetailViewController {
        let viewModel = LifestyleDetailViewModel(
            selectedLifestyles: selectedLifestyles,
            delegate: context.coordinator
        )
        let viewController = LifestyleDetailViewController(viewModel: viewModel)
        viewController.delegate = context.coordinator
        viewController.selectedLifestyles = selectedLifestyles

        return viewController
    }

    func updateUIViewController(_ uiViewController: LifestyleDetailViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(selectedLifestyles: $selectedLifestyles)
    }

    class Coordinator: NSObject, LifestyleDetailDelegate {
        var selectedLifestyles: Binding<[LifestyleItem]>

        init(selectedLifestyles: Binding<[LifestyleItem]>) {
            self.selectedLifestyles = selectedLifestyles
        }

        func lifestyleDetailViewController(_ controller: LifestyleDetailViewController, didUpdateLifestyles lifestyles: [LifestyleItem]) {
            selectedLifestyles.wrappedValue = lifestyles
        }
    }
}
