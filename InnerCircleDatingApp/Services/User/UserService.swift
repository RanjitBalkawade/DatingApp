//
//  UserService.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import Foundation

class UserService: UserServiceProtocol {

    init() {}

    func fetchUserProfile(for email: String) async throws -> UserDTO {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

        return UserDTO(
            email: email,
            name: nil,
            job: nil,
            birthday: nil,
            height: nil,
            hasChildren: nil,
            datingIntentions: nil,
            gender: nil,
            photos: nil,
            lifestyles: nil,
            socialConnected: nil
        )
    }
}
