//
//  NameView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI

struct NameView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var name: String = ""
    @State private var showError: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Text("What's your name?")
                .font(AppTheme.Fonts.titleSwiftUI)
                .multilineTextAlignment(.center)

            Text("This is how you'll appear to others")
                .font(AppTheme.Fonts.bodySwiftUI)
                .foregroundColor(Color(AppTheme.Colors.secondaryText))
                .multilineTextAlignment(.center)

            TextField("Enter your name", text: $name)
                .font(AppTheme.Fonts.bodySwiftUI)
                .padding()
                .background(Color(AppTheme.Colors.secondaryBackground))
                .cornerRadius(AppTheme.CornerRadius.medium)
                .padding(.horizontal, 40)
                .padding(.top, 20)

            if showError {
                Text("Please enter your name")
                    .font(.system(size: 14))
                    .foregroundColor(Color(AppTheme.Colors.error))
            }

            Spacer()

            HStack(spacing: AppTheme.Spacing.md) {
                Button(action: {
                    viewModel.previousStep()
                }) {
                    Text("Back")
                        .font(AppTheme.Fonts.headlineSwiftUI)
                        .foregroundColor(AppTheme.Colors.primarySwiftUI)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(AppTheme.Colors.primarySwiftUI.opacity(0.1))
                        .cornerRadius(AppTheme.CornerRadius.medium)
                }

                Button(action: {
                    if name.trimmingCharacters(in: .whitespaces).isEmpty {
                        showError = true
                    } else {
                        showError = false
                        viewModel.updateName(name)
                        viewModel.nextStep()
                    }
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
        .onAppear {
            if let existingName = viewModel.user.name {
                name = existingName
            }
        }
    }
}
