//
//  SceneDelegate.swift
//  SLP
//
//  Created by Kanghos on 2022/01/18.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        //window?.rootViewController = UINavigationController(rootViewController: MyPageViewController())
        //window?.makeKeyAndVisible()
//        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "arrow")
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "arrow")
//
        if Auth.auth().currentUser == nil {
            window?.rootViewController =  UINavigationController(rootViewController: PhoneViewController())
            window?.makeKeyAndVisible()
            
            return
        } else {
            Auth.auth().currentUser?.getIDToken(completion: { idToken, error in
                guard let idToken = idToken else {
                    self.window?.rootViewController =  UINavigationController(rootViewController: PhoneViewController())
                    self.window?.makeKeyAndVisible()
                    
                    return
                }
                
                UserDefaults.standard.set(idToken, forKey: "idToken")
                
                DispatchQueue.main.async {
                    APIService.getUser { user, statusCode, error in
                        guard let statusCode = statusCode else {
                            return
                        }
                        
                        switch statusCode {
                        case 200:
                            self.window?.rootViewController =  CustomTabBarController()
                            self.window?.makeKeyAndVisible()
                        case 401:
                            self.window?.rootViewController =  UINavigationController(rootViewController: NicknameViewController())
                            self.window?.makeKeyAndVisible()
                        default :
                            self.window?.rootViewController =  UINavigationController(rootViewController: PhoneViewController())
                            self.window?.makeKeyAndVisible()
                            
                        }
                    }
                }
                
                
                
                
            })
        }
        
       
        //UINavigationBar.appearance().backItem = UINavigationItem(title: "")
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }



}

