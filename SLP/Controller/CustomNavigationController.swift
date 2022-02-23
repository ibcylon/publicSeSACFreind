//
//  CustomNavigationController.swift
//  SLP
//
//  Created by Kanghos on 2022/02/04.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes = [
            .font: UIFont.Title3_M14!
        ]
    }
}
