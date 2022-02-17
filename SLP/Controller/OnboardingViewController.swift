//
//  OnboardingViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/02/17.
//
import UIKit

class OnboardingViewController: UIViewController {
    override func viewDidLoad() {
        Storage.setCurrentState(scene: Scene.auth)
    }
}
