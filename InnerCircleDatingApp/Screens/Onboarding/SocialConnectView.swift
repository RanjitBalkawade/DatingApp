//
//  SocialConnectView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI

struct SocialConnectView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "link.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Text("Connect Your Social Media")
                .font(AppTheme.Fonts.titleSwiftUI)
                .multilineTextAlignment(.center)

            Text("Link your Instagram or Facebook\n(Optional)")
                .font(AppTheme.Fonts.bodySwiftUI)
                .foregroundColor(Color(AppTheme.Colors.secondaryText))
                .multilineTextAlignment(.center)

            VStack(spacing: AppTheme.Spacing.md) {
                Button(action: {
                    viewModel.updateSocialConnected(true)
                }) {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Connect Instagram")
                    }
                    .font(AppTheme.Fonts.bodySwiftUI)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.purple)
                    .cornerRadius(AppTheme.CornerRadius.medium)
                }

                Button(action: {
                    viewModel.updateSocialConnected(true)
                }) {
                    HStack {
                        Image(systemName: "person.2.fill")
                        Text("Connect Facebook")
                    }
                    .font(AppTheme.Fonts.bodySwiftUI)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(AppTheme.CornerRadius.medium)
                }
            }
            .padding(.horizontal, 40)

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
                    viewModel.nextStep()
                }) {
                    Text("Skip")
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
    SocialConnectView(viewModel: OnboardingViewModel(email: "preview@test.com", coordinator: nil))
}
