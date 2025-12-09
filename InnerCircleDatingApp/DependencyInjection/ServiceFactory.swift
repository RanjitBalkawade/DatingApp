//
//  ServiceFactory.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 06/12/25.
//


import Foundation

// MARK: - Service Factory Protocol
protocol ServiceFactoryProtocol {
    func makeAuthenticationService() -> AuthenticationServiceProtocol
    func makeUserService() -> UserServiceProtocol
}

// MARK: - Default Service Factory
final class ServiceFactory: ServiceFactoryProtocol {

    init() {}

    // MARK: - Service Creation

    func makeAuthenticationService() -> AuthenticationServiceProtocol {
        return AuthenticationService()
    }

    func makeUserService() -> UserServiceProtocol {
        return UserService()
    }
}

// MARK: - Dependency Container
final class DependencyContainer {

    // Service Factory
    let serviceFactory: ServiceFactoryProtocol

    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
    }

    // MARK: - Service Accessors

    lazy var authenticationService: AuthenticationServiceProtocol = {
        return serviceFactory.makeAuthenticationService()
    }()

    lazy var userService: UserServiceProtocol = {
        return serviceFactory.makeUserService()
    }()
}
