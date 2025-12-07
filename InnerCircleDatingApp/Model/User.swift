//
//  User.swift
//  InnerCircleDatingApp
//
//  Created by Ranjeet Balkawade on 07/12/25.
//

import Foundation
import Combine

// MARK: - UserDTO (Immutable - for API)
struct UserDTO: Codable {
    let email: String
    let name: String?
    let job: String?
    let birthday: Date?
    let height: Int?
    let hasChildren: Bool?
    let datingIntentions: String?
    let gender: String?
    let photos: [String]?
    let lifestyles: [LifestyleItem]?
    let socialConnected: Bool?

    // MARK: - Mapper
    func toUser() -> User {
        return User(
            email: email,
            name: name,
            job: job,
            birthday: birthday,
            height: height,
            hasChildren: hasChildren,
            datingIntentions: datingIntentions,
            gender: gender,
            photos: photos ?? [],
            lifestyles: lifestyles ?? [],
            socialConnected: socialConnected
        )
    }
}

// MARK: - User (Mutable - for App)
class User: ObservableObject {
    @Published var email: String
    @Published var name: String?
    @Published var job: String?
    @Published var birthday: Date?
    @Published var height: Int?
    @Published var hasChildren: Bool?
    @Published var datingIntentions: String?
    @Published var gender: String?
    @Published var photos: [String]
    @Published var lifestyles: [LifestyleItem]
    @Published var socialConnected: Bool?

    init(
        email: String,
        name: String? = nil,
        job: String? = nil,
        birthday: Date? = nil,
        height: Int? = nil,
        hasChildren: Bool? = nil,
        datingIntentions: String? = nil,
        gender: String? = nil,
        photos: [String] = [],
        lifestyles: [LifestyleItem] = [],
        socialConnected: Bool? = nil
    ) {
        self.email = email
        self.name = name
        self.job = job
        self.birthday = birthday
        self.height = height
        self.hasChildren = hasChildren
        self.datingIntentions = datingIntentions
        self.gender = gender
        self.photos = photos
        self.lifestyles = lifestyles
        self.socialConnected = socialConnected
    }
}

// MARK: - LifestyleItem
struct LifestyleItem: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    let detail: String?

    init(id: UUID = UUID(), name: String, detail: String? = nil) {
        self.id = id
        self.name = name
        self.detail = detail
    }

    func with(detail: String?) -> LifestyleItem {
        LifestyleItem(id: id, name: name, detail: detail)
    }

    static func == (lhs: LifestyleItem, rhs: LifestyleItem) -> Bool {
        return lhs.id == rhs.id
    }
}

