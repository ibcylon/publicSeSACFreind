//
//  UserManager.swift
//  SLP
//
//  Created by Kanghos on 2022/02/22.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    private let userDefaults: UserDefaults
    private let defaultValue: T

    let key: String

    var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: self.key) as? T ?? self.defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: self.key) }
    }

    init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
}

class UserManager {

    @UserDefault(key: "idToken", defaultValue: nil)
    static var idToken: String?

    @UserDefault(key: "fcmToken", defaultValue: nil)
    static var fcmToken: String?

    @UserDefault(key: "birth", defaultValue: nil)
    static var birth: String?

    @UserDefault(key: "email", defaultValue: nil)
    static var email: String?

    @UserDefault(key: "nickname", defaultValue: nil)
    static var nickname: String?

    @UserDefault(key: "phoneNumber", defaultValue: nil)
    static var phoneNumber: String?

    @UserDefault(key: "gender", defaultValue: Gender.none.rawValue)
    static var gender: Int

    @UserDefault(key: "status", defaultValue: MatchingStatus.normal.rawValue)
    static var status: Int

    @UserDefault(key: "authVerificationID", defaultValue: nil)
    static var authVerificationID: String?

    @UserDefault(key: "currentState", defaultValue: Scene.onboarding.rawValue)
    static var currentState: Int

}

enum MatchingStatus: Int {
    case normal = 0
    case matching = 1
    case matched = 2

    var image: String {
        switch self {
        case .normal:
            return "default"
        case .matching:
            return "matching"
        case .matched:
            return "matched"
        }
    }
}
