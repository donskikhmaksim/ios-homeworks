//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Максим Донских on 27.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        
        let loginInspector = MyLoginFactory().makeLoginInspector()
        
        let factory = ModuleFactory(loginInspetor: loginInspector)
        let appCoordinator = AppCoordinator(factory: factory)
        
        self.window = UIWindow(windowScene: scene)
        self.appCoordinator = appCoordinator
        
        

        
        self.window?.rootViewController = appCoordinator.start()
        self.window?.makeKeyAndVisible()
    }
}

