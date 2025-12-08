//
//  LifestylesView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 08/12/25.
//

import SwiftUI

struct LifestylesView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showDetailView = false

    var body: some View {
        VStack(spacing: 0) {
            if !showDetailView {
                selectionView
            } else {
                detailView
            }
        }
    }

    private var lifestylesBinding: Binding<[LifestyleItem]> {
        Binding(
            get: { viewModel.user.lifestyles },
            set: { viewModel.updateLifestyles($0) }
        )
    }

    private var selectionView: some View {
        VStack(spacing: 30) {
            Spacer()

            Text("Your Lifestyle")
                .font(AppTheme.Fonts.titleSwiftUI)
                .multilineTextAlignment(.center)

            Text("Select activities and interests that define you")
                .font(AppTheme.Fonts.bodySwiftUI)
                .foregroundColor(Color(AppTheme.Colors.secondaryText))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            LifestyleSelectionViewRepresentable(
                selectedLifestyles: lifestylesBinding
            )
            .frame(height: 400)
            .padding(.horizontal, 20)

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
                    if !viewModel.user.lifestyles.isEmpty {
                        showDetailView = true
                    }
                }) {
                    Text("Continue")
                        .font(AppTheme.Fonts.headlineSwiftUI)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(viewModel.user.lifestyles.isEmpty ? Color.gray : AppTheme.Colors.primarySwiftUI)
                        .cornerRadius(AppTheme.CornerRadius.medium)
                }
                .disabled(viewModel.user.lifestyles.isEmpty)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }

    private var detailView: some View {
        ZStack {
            LifestyleDetailViewRepresentable(
                selectedLifestyles: lifestylesBinding
            )
            .ignoresSafeArea(.keyboard)

            VStack {
                Spacer()

                HStack(spacing: AppTheme.Spacing.md) {
                    Button(action: {
                        showDetailView = false
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
                .background(Color(UIColor.systemBackground))
            }
        }
    }
}

