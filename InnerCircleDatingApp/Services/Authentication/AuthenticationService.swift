//
//  AuthenticationService.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    init() {}

    func login(email: String, password: String) async throws -> UserType {
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        return checkUserStatus(email: email)
    }

    func checkUserStatus(email: String) -> UserType {
        return email.lowercased().contains("new") ? .new : .approved
    }
}
