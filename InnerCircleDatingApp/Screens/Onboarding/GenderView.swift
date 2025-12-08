//
//  GenderView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import SwiftUI

struct GenderView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    let genders = ["Male", "Female", "Non-binary", "Prefer not to say"]

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "person.2.fill")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Text("What's your gender?")
                .font(AppTheme.Fonts.titleSwiftUI)

            VStack(spacing: AppTheme.Spacing.sm) {
                ForEach(genders, id: \.self) { gender in
                    Button(action: {
                        viewModel.updateGender(gender)
                        viewModel.nextStep()
                    }) {
                        Text(gender)
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

