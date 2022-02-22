//
//  Storage.swift
//  SLP
//
//  Created by Kanghos on 2022/02/17.
//

import UIKit

enum Scene: Int {
    case onboarding = 0
    case auth = 1
    case email = 2
    case main = 3
}

extension Scene {
    var viewController: UIViewController {
        switch self {
        case .onboarding:
            return UINavigationController(rootViewController: OnboardingViewController())
        case .auth:
            return UINavigationController(rootViewController: PhoneViewController())
        case .email:
            return UINavigationController(rootViewController: EmailViewController())
        case .main:
            return CustomTabBarController()
        }
    }
}

class Storage {
    static let key: String = "currentState"
    static func currentState() -> UIViewController {
        let defaults = UserDefaults.standard
        let currentState: Scene = Scene(rawValue: defaults.integer(forKey: key)) ?? .onboarding
        
        return currentState.viewController
    }
    
    static func setCurrentState(scene: Scene) {
        let defaults = UserDefaults.standard
        defaults.set(scene.rawValue, forKey: key)
    }
}
    
