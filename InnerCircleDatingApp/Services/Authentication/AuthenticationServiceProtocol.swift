//
//  AuthenticationServiceProtocol.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 05/12/25.
//

import Foundation

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) async throws -> UserType
    func checkUserStatus(email: String) -> UserType
}
