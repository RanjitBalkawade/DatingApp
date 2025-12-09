//
//  IntroView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI

struct IntroView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Text("💕")
                .font(.system(size: 100))

            Text("Welcome to InnerCircle")
                .font(AppTheme.Fonts.largeTitleSwiftUI)
                .multilineTextAlignment(.center)

            Text("Let's create your perfect dating profile")
                .font(AppTheme.Fonts.bodySwiftUI)
                .foregroundColor(Color(AppTheme.Colors.secondaryText))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            VStack(alignment: .leading, spacing: 16) {
                FeatureRow(icon: "checkmark.circle.fill", text: "Share your interests")
                FeatureRow(icon: "checkmark.circle.fill", text: "Connect authentically")
                FeatureRow(icon: "checkmark.circle.fill", text: "Find meaningful connections")
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)

            Spacer()

            Button(action: {
                viewModel.nextStep()
            }) {
                Text("Get Started")
                    .font(AppTheme.Fonts.headlineSwiftUI)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(AppTheme.Colors.primarySwiftUI)
                    .cornerRadius(AppTheme.CornerRadius.medium)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.Colors.primarySwiftUI)
                .font(.system(size: 20))

            Text(text)
                .font(AppTheme.Fonts.bodySwiftUI)
        }
    }
}

#Preview {
    IntroView(viewModel: OnboardingViewModel(email: "preview@test.com", coordinator: nil))
}
