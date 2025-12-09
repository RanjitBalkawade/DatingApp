//
//  ConfirmationView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import SwiftUI

struct ConfirmationView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 30) {
                Text("Profile Summary")
                    .font(AppTheme.Fonts.largeTitleSwiftUI)
                    .padding(.top, 20)

                Text("Review your information before completing")
                    .font(AppTheme.Fonts.bodySwiftUI)
                    .foregroundColor(Color(AppTheme.Colors.secondaryText))
                    .multilineTextAlignment(.center)

                VStack(spacing: 20) {
                    if let name = viewModel.user.name {
                        InfoCard(title: "Name", value: name, icon: "person.fill")
                    }

                    if let job = viewModel.user.job {
                        InfoCard(title: "Job", value: job, icon: "briefcase.fill")
                    }

                    if let height = viewModel.user.height {
                        InfoCard(title: "Height", value: "\(height) cm", icon: "ruler.fill")
                    }

                    if let hasChildren = viewModel.user.hasChildren {
                        InfoCard(title: "Children", value: hasChildren ? "Yes" : "No", icon: "figure.and.child.holdinghands")
                    }

                    if let intentions = viewModel.user.datingIntentions {
                        InfoCard(title: "Dating Intentions", value: intentions, icon: "heart.fill")
                    }

                    if let gender = viewModel.user.gender {
                        InfoCard(title: "Gender", value: gender, icon: "person.2.fill")
                    }

                    if !viewModel.user.lifestyles.isEmpty {
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                            HStack {
                                Image(systemName: "sparkles")
                                    .foregroundColor(AppTheme.Colors.primarySwiftUI)
                                Text("Lifestyles")
                                    .font(AppTheme.Fonts.bodySwiftUI)
                                Spacer()
                            }

                            ForEach(viewModel.user.lifestyles) { lifestyle in
                                VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                                    HStack {
                                        Text("•")
                                            .foregroundColor(AppTheme.Colors.primarySwiftUI)
                                        Text(lifestyle.name)
                                            .font(.system(size: 14, weight: .semibold))
                                        Spacer()
                                    }

                                    if let detail = lifestyle.detail, !detail.isEmpty {
                                        Text(detail)
                                            .font(.system(size: 13))
                                            .foregroundColor(Color(AppTheme.Colors.secondaryText))
                                            .padding(.leading, 20)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(AppTheme.Colors.primarySwiftUI.opacity(0.1))
                        .cornerRadius(AppTheme.CornerRadius.medium)
                    }
                }
                .padding(.horizontal, 20)

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
                        viewModel.completeOnboarding()
                    }) {
                        Text(viewModel.submissionState.isLoading ? "Submitting..." : "Complete")
                            .font(AppTheme.Fonts.headlineSwiftUI)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(viewModel.submissionState.isLoading ? Color.gray : AppTheme.Colors.primarySwiftUI)
                            .cornerRadius(AppTheme.CornerRadius.medium)
                    }
                    .disabled(viewModel.submissionState.isLoading)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
                }
            }

            // Loading overlay
            if viewModel.submissionState.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                VStack(spacing: AppTheme.Spacing.md) {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(AppTheme.Colors.primarySwiftUI)
                    Text("Creating your profile...")
                        .font(AppTheme.Fonts.bodySwiftUI)
                        .foregroundColor(.white)
                }
                .padding(40)
                .background(Color.white)
                .cornerRadius(AppTheme.CornerRadius.large)
                .shadow(radius: 20)
            }
        }
        .alert("Submission Error", isPresented: .constant(viewModel.submissionState.error != nil)) {
            Button("OK", role: .cancel) {
                viewModel.submissionState = .idle
            }
        } message: {
            Text(viewModel.submissionState.error?.localizedDescription ?? "An error occurred")
        }
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(AppTheme.Colors.primarySwiftUI)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(Color(AppTheme.Colors.secondaryText))
                Text(value)
                    .font(.system(size: 16, weight: .medium))
            }

            Spacer()
        }
        .padding()
        .background(AppTheme.Colors.primarySwiftUI.opacity(0.1))
        .cornerRadius(AppTheme.CornerRadius.medium)
    }
}

#Preview {
    ConfirmationView(viewModel: OnboardingViewModel(email: "preview@test.com", coordinator: nil))
}
