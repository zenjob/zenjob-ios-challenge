 //
//  SceneDelegate.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var environment: Environment
    var dispatcher: NetworkDispatcher
    
    override init() {
      environment = Environment("staging", host: "https://staging-main.zenjob.org/api/employee/v1")
      dispatcher = NetworkDispatcher(environment: environment)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let loginTask = LoginTask(username: "mobile@zenjob.com", password: "becreative")
        loginTask.execute(in: dispatcher) { [weak self] (user, error) in
            if let error = error {
                print("error in LoginTast \(error.localizedDescription)")
            }
            
            if let user = user {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(user.accessToken, forKey: "accessToken")
                    
                    let tabBarController = TabBarController(dispatcher: self!.dispatcher, user: user)
                    window.rootViewController = tabBarController
                    self?.window = window
                    window.makeKeyAndVisible()
                }
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

