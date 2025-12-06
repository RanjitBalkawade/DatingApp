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
}

// MARK: - Default Service Factory
final class ServiceFactory: ServiceFactoryProtocol {

    static let shared = ServiceFactory()

    private init() {}

    // MARK: - Service Creation
    func makeAuthenticationService() -> AuthenticationServiceProtocol {
        return AuthenticationService()
    }
}

// MARK: - Dependency Container
final class DependencyContainer {

    static let shared = DependencyContainer()

    let serviceFactory: ServiceFactoryProtocol

    private init(serviceFactory: ServiceFactoryProtocol = ServiceFactory.shared) {
        self.serviceFactory = serviceFactory
    }

    // MARK: - Service Accessors
    lazy var authenticationService: AuthenticationServiceProtocol = {
        return serviceFactory.makeAuthenticationService()
    }()

    // MARK: - Testing Support
    static func makeForTesting(serviceFactory: ServiceFactoryProtocol) -> DependencyContainer {
        return DependencyContainer(serviceFactory: serviceFactory)
    }
}
