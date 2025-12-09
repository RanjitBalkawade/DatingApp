//
//  PhotoSelectionView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import SwiftUI

struct PhotoSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Text("Add your photos")
                .font(AppTheme.Fonts.titleSwiftUI)

            Text("Choose at least 2 photos")
                .font(AppTheme.Fonts.bodySwiftUI)
                .foregroundColor(Color(AppTheme.Colors.secondaryText))

            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: AppTheme.Spacing.sm) {
                ForEach(0..<6) { index in
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.medium)
                        .fill(AppTheme.Colors.primarySwiftUI.opacity(0.1))
                        .frame(height: 120)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .foregroundColor(AppTheme.Colors.primarySwiftUI.opacity(0.5))
                        )
                }
            }
            .padding(.horizontal, 40)

            Spacer()

            HStack(spacing: AppTheme.Spacing.md) {
                Button(action: { viewModel.previousStep() }) {
                    Text("Back")
                        .font(AppTheme.Fonts.headlineSwiftUI)
                        .foregroundColor(AppTheme.Colors.primarySwiftUI)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(AppTheme.Colors.primarySwiftUI.opacity(0.1))
                        .cornerRadius(AppTheme.CornerRadius.medium)
                }

                Button(action: {
                    viewModel.nextStep()
                }) {
                    Text("Next")
                        .font(AppTheme.Fonts.headlineSwiftUI)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(AppTheme.Colors.primarySwiftUI)
                        .cornerRadius(AppTheme.CornerRadius.medium)
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    PhotoSelectionView(viewModel: OnboardingViewModel(email: "preview@test.com", coordinator: nil))
}
