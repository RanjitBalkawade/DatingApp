//
//  OnboardingContainerView.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI

struct OnboardingContainerView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.cancelOnboarding()
                        }) {
                            Text("Cancel")
                                .font(.subheadline)
                                .foregroundColor(.red)
                                .padding(.trailing, 16)
                        }
                    }
                    ProgressView(value: viewModel.progress)
                        .tint(.pink)
                }
                .padding()
            }
            Spacer()
            

            Text(viewModel.currentStep.title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)

            switch viewModel.currentStep {
            case .intro:
                IntroView(viewModel: viewModel)
            case .socialConnect:
                SocialConnectView(viewModel: viewModel)
            case .name:
                NameView(viewModel: viewModel)
            case .job:
                JobView(viewModel: viewModel)
            case .birthday:
                BirthdayView(viewModel: viewModel)
            case .height:
                HeightView(viewModel: viewModel)
            case .children:
                ChildrenView(viewModel: viewModel)
            case .datingIntentions:
                DatingIntentionsView(viewModel: viewModel)
            case .gender:
                GenderView(viewModel: viewModel)
            case .photos:
                PhotoSelectionView(viewModel: viewModel)
            case .lifestyles:
                LifestylesView(viewModel: viewModel)
            case .confirmation:
                ConfirmationView(viewModel: viewModel)
            }
        }
        .navigationBarHidden(true)
    }
}
