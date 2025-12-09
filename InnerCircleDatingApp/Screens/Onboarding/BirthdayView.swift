//
//  BirthdayView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI

struct BirthdayView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedDate = Date()

    var body: some View {

        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "calendar")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Text("When's your birthday?")
                .font(AppTheme.Fonts.titleSwiftUI)

            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.wheel)
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
                    viewModel.updateBirthday(selectedDate)
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
            if let birthday = viewModel.user.birthday {
                selectedDate = birthday
            }
        }
    }
}

#Preview {
    BirthdayView(viewModel: OnboardingViewModel(email: "preview@test.com", coordinator: nil))
}
