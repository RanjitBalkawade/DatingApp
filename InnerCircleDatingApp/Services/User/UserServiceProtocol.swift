//
//  UserServiceProtocol.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUserProfile(for email: String) async throws -> UserDTO
}
