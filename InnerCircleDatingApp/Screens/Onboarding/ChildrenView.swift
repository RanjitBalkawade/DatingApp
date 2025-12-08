//
//  ChildrenView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import SwiftUI

struct ChildrenView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "figure.and.child.holdinghands")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Text("Do you have children?")
                .font(AppTheme.Fonts.titleSwiftUI)

            HStack(spacing: AppTheme.Spacing.md) {
                Button(action: {
                    viewModel.updateHasChildren(true)
                    viewModel.nextStep()
                }) {
                    VStack(spacing: AppTheme.Spacing.sm) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(AppTheme.Colors.primarySwiftUI)
                        Text("Yes")
                            .font(AppTheme.Fonts.headlineSwiftUI)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(AppTheme.Colors.primarySwiftUI.opacity(0.1))
                    .cornerRadius(AppTheme.CornerRadius.large)
                }

                Button(action: {
                    viewModel.updateHasChildren(false)
                    viewModel.nextStep()
                }) {
                    VStack(spacing: AppTheme.Spacing.sm) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(AppTheme.Colors.primarySwiftUI)
                        Text("No")
                            .font(AppTheme.Fonts.headlineSwiftUI)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(AppTheme.Colors.primarySwiftUI.opacity(0.1))
                    .cornerRadius(AppTheme.CornerRadius.large)
                }
            }
            .padding(.horizontal, 40)

            Spacer()

            Button(action: { viewModel.previousStep() }) {
                Text("Back")
                    .font(AppTheme.Fonts.headlineSwiftUI)
                    .foregroundColor(AppTheme.Colors.primarySwiftUI)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(AppTheme.Colors.primarySwiftUI.opacity(0.1))
                    .cornerRadius(AppTheme.CornerRadius.medium)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
}

