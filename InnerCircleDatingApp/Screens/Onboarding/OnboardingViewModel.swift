//
//  OnboardingViewModel.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import SwiftUI
import Combine

enum OnboardingStep: Int, CaseIterable {
    case intro = 0
    case socialConnect
    case name
    case job
    case birthday
    case height
    case children
    case datingIntentions
    case gender
    case photos
    case lifestyles
    case confirmation

    var title: String {
        switch self {
        case .intro: return "Welcome"
        case .socialConnect: return "Connect Social"
        case .name: return "Your Name"
        case .job: return "Your Job"
        case .birthday: return "Birthday"
        case .height: return "Height"
        case .children: return "Children"
        case .datingIntentions: return "Intentions"
        case .gender: return "Gender"
        case .photos: return "Photos"
        case .lifestyles: return "Lifestyles"
        case .confirmation: return "Confirm"
        }
    }
}

@MainActor
class OnboardingViewModel: ObservableObject {
    @Published var currentStep: OnboardingStep = .intro
    @Published var submissionState: ViewState<User> = .idle
    @ObservedObject var user: User

    weak var coordinator: OnboardingCoordinator?
    private var cancellables = Set<AnyCancellable>()

    init(email: String, coordinator: OnboardingCoordinator? = nil) {
        self.user = User(email: email)
        self.coordinator = coordinator

        // Forward User's objectWillChange to ViewModel's objectWillChange
        // This ensures views observing ViewModel update when User properties change
        user.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        .store(in: &cancellables)
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

    func updateHasChildren(_ hasChildren: Bool?) {
        user.hasChildren = hasChildren
    }

    func updateDatingIntentions(_ intentions: String?) {
        user.datingIntentions = intentions
    }

    func updateGender(_ gender: String?) {
        user.gender = gender
    }

    func updatePhotos(_ photos: [String]) {
        user.photos = photos
    }

    func updateLifestyles(_ lifestyles: [LifestyleItem]) {
        user.lifestyles = lifestyles
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

    func completeOnboarding() {
        Task {
            submissionState = .loading

            // Simulate API call to submit profile
            do {
                try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
                submissionState = .success(user)
                coordinator?.didCompleteOnboarding(user: user)
            } catch {
                submissionState = .error(error)
            }
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
