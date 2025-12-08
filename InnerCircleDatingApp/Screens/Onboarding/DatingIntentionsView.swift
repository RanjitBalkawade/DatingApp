//
//  DatingIntentionsView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import SwiftUI

struct DatingIntentionsView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    let intentions = ["Long-term relationship", "Short-term fun", "Friendship", "Not sure yet"]

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Text("What are you looking for?")
                .font(AppTheme.Fonts.titleSwiftUI)
                .multilineTextAlignment(.center)

            VStack(spacing: AppTheme.Spacing.sm) {
                ForEach(intentions, id: \.self) { intention in
                    Button(action: {
                        viewModel.updateDatingIntentions(intention)
                        viewModel.nextStep()
                    }) {
                        Text(intention)
                            .font(AppTheme.Fonts.bodySwiftUI)
                            .foregroundColor(Color(AppTheme.Colors.text))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(AppTheme.Colors.primarySwiftUI.opacity(0.1))
                            .cornerRadius(AppTheme.CornerRadius.medium)
                    }
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

