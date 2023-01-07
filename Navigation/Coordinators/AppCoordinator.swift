//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Максим Донских on 30.12.2022.
//

import UIKit

class AppCoordinator: Coordinatable {
    private(set) var childCoordinators: [Coordinatable] = []
    
    private let factory: ModuleFactory
    
    init(factory: ModuleFactory) {
        self.factory = factory
    }
    
    func start() -> UIViewController{
        let feedCoordinator = FeedCoordinator(moduleType: .feed, factory: factory)
        let loginCoordinator = LoginCoordinator(moduleType: .profile, factory: factory)
        
        let appTabBarController = AppTapBarController(viewControllers: [
            feedCoordinator.start(),
            loginCoordinator.start()
        ])
        
        addChildCoordinator(feedCoordinator)
        addChildCoordinator(loginCoordinator)
        
        return appTabBarController
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter( {$0 === coordinator} )
    }
    
}

