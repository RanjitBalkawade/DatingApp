//
//  AppDestination.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 09/12/25.
//

import Foundation

// MARK: - App Destination
enum AppDestination {
    case login
    case onboarding(email: String)
    case home(email: String)
}

