//
//  File.swift
//  Navigation
//
//  Created by Максим Донских on 30.12.2022.
//

import UIKit

final class FeedCoordinator: ModuleCoordinatable {
    private(set) var module: Module?
    private(set) var childCoordinators: [Coordinatable] = []
    
    private let factory: ModuleFactory
    
    var moduleType: Module.ModuleType
    
    init(moduleType: Module.ModuleType, factory: ModuleFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(typeOf: moduleType)
        let viewController = module.viewController
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? FeedViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushPostVC() {
        let vc = PostViewController(coordinator: self)
        (module?.viewController as? UINavigationController)?.pushViewController(vc, animated: true)
    }
    
    func presentInfoVC() {
        let vc = InfoViewController()
        (module?.viewController as? UINavigationController)?.present(vc, animated: true)
    }
    
}
