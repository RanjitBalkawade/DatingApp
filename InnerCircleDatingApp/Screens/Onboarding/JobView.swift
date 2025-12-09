//
//  JobView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI

struct JobView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var job: String = ""

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "briefcase.fill")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Text("What do you do?")
                .font(AppTheme.Fonts.titleSwiftUI)

            TextField("Enter your job title", text: $job)
                .font(AppTheme.Fonts.bodySwiftUI)
                .padding()
                .background(Color(AppTheme.Colors.secondaryBackground))
                .cornerRadius(AppTheme.CornerRadius.medium)
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
                    if !job.isEmpty {
                        viewModel.updateJob(job)
                    }
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
        .onAppear {
            if let existingJob = viewModel.user.job {
                job = existingJob
            }
        }
    }
}

#Preview {
    JobView(viewModel: OnboardingViewModel(email: "preview@test.com", coordinator: nil))
}
