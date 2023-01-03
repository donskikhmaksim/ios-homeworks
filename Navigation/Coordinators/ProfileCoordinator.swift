//
//  File.swift
//  Navigation
//
//  Created by Максим Донских on 30.12.2022.
//

import UIKit

final class ProfileCoordinator: ModuleCoordinatable {
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
        (module.viewModel as? LoginViewModel)?.coordinator = self
//        print((module.viewModel as? LoginViewModel)?.coordinator)
        self.module = module
        return viewController
    }
    
    func pushIntoProfileVC(user: User) {
        let vc = ProfileViewController(user: user)
        (module?.viewController as? UINavigationController)?.pushViewController(vc, animated: true)
    }
    
}
