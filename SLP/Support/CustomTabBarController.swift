//
//  CustomTabbar.swift
//  SLP
//
//  Created by Kanghos on 2022/02/04.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .brandGreen
        self.tabBar.unselectedItemTintColor = .gray6
        self.tabBar.backgroundColor = .white
        
        self.navigationController?.isNavigationBarHidden = true
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.image = UIImage(named: "homeInact")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "homeAct")
        homeViewController.tabBarItem.title = "홈"
        
        let shopViewController = UINavigationController(rootViewController: MainViewController())
        shopViewController.tabBarItem.image = UIImage(named: "shopInact")
        shopViewController.tabBarItem.selectedImage = UIImage(named: "shopAct")
        shopViewController.tabBarItem.title = "새싹샵"
        
        let friendsViewController = UINavigationController(rootViewController: MainViewController())
        friendsViewController.tabBarItem.image = UIImage(named: "friendsInact")
        friendsViewController.tabBarItem.selectedImage = UIImage(named: "friendsAct")
        friendsViewController.tabBarItem.title = "새싹친구"
        
        let myPageViewController = UINavigationController(rootViewController: MyPageViewController())
        myPageViewController.tabBarItem.image = UIImage(named: "myPageInact")
        myPageViewController.tabBarItem.selectedImage = UIImage(named: "myPageAct")
        myPageViewController.tabBarItem.title = "내정보"
        
        viewControllers = [homeViewController, shopViewController, friendsViewController, myPageViewController]
        
    }
    
}
