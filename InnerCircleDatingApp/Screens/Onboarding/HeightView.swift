//
//  HeightView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI

struct HeightView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var height: Double = 170

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "ruler.fill")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Text("How tall are you?")
                .font(AppTheme.Fonts.titleSwiftUI)

            Text("\(Int(height)) cm")
                .font(AppTheme.Fonts.largeTitleSwiftUI)
                .foregroundColor(AppTheme.Colors.primarySwiftUI)

            Slider(value: $height, in: 140...220, step: 1)
                .padding(.horizontal, 40)
                .tint(AppTheme.Colors.primarySwiftUI)

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
                    viewModel.updateHeight(Int(height))
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
            if let existingHeight = viewModel.user.height {
                height = Double(existingHeight)
            }
        }
    }
}
