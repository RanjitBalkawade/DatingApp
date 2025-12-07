//
//  OnboardingViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    case intro = 0
    case socialConnect
    case name
    case job
    case birthday
    case height

    var title: String {
        switch self {
        case .intro: return "Welcome"
        case .socialConnect: return "Connect Social"
        case .name: return "Your Name"
        case .job: return "Your Job"
        case .birthday: return "Birthday"
        case .height: return "Height"
        }
    }
}

@MainActor
class OnboardingViewModel: ObservableObject {
    @Published var currentStep: OnboardingStep = .intro
    @Published var submissionState: ViewState<User> = .idle
    @ObservedObject var user: User

    weak var coordinator: OnboardingCoordinator?

    init(email: String, coordinator: OnboardingCoordinator) {
        self.user = User(email: email)
        self.coordinator = coordinator
    }

    // MARK: - User Update Methods
    func updateName(_ name: String?) {
        user.name = name
    }

    func updateJob(_ job: String?) {
        user.job = job
    }

    func updateBirthday(_ birthday: Date?) {
        user.birthday = birthday
    }

    func updateHeight(_ height: Int?) {
        user.height = height
    }

    func updateSocialConnected(_ connected: Bool?) {
        user.socialConnected = connected
    }

    // MARK: - Navigation
    func nextStep() {
        if let currentIndex = OnboardingStep.allCases.firstIndex(of: currentStep),
           currentIndex < OnboardingStep.allCases.count - 1 {
            currentStep = OnboardingStep.allCases[currentIndex + 1]
        }
    }

    func previousStep() {
        if let currentIndex = OnboardingStep.allCases.firstIndex(of: currentStep),
           currentIndex > 0 {
            currentStep = OnboardingStep.allCases[currentIndex - 1]
        }
    }
    
    func cancelOnboarding() {
        coordinator?.didCancelOnboarding()
    }

    var progress: Double {
        let currentIndex = Double(OnboardingStep.allCases.firstIndex(of: currentStep) ?? 0)
        let totalSteps = Double(OnboardingStep.allCases.count)
        return currentIndex / totalSteps
    }
}
