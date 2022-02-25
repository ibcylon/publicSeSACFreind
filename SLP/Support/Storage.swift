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
    case nickname = 2
    case main = 3
}

extension Scene {

    var viewController: UIViewController {
        switch self {
        case .onboarding:
            return UINavigationController(rootViewController: OnboardingViewController())
        case .auth:
            return UINavigationController(rootViewController: PhoneViewController())
        case .nickname:
            return UINavigationController(rootViewController: NicknameViewController())
        case .main:
            return CustomTabBarController()
        }
    }
}

final class Storage {

    static func currentState() -> UIViewController {
        let currentState: Scene = Scene(rawValue: UserManager.currentState) ?? .onboarding
        
        return currentState.viewController
    }
    
    static func setCurrentState(scene: Scene) {
        UserManager.currentState = scene.rawValue
    }
}
    
