//
//  File.swift
//  Navigation
//
//  Created by Максим Донских on 30.12.2022.
//

import UIKit

final class ModuleFactory {
    
    private var loginInspetor: LoginInspector
    
    init(loginInspetor: LoginInspector) {
        self.loginInspetor = loginInspetor
    }
    
    func makeModule(typeOf moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .feed:
            let viewModel = LoginViewModel(loginInspector: loginInspetor)
            let viewController = UINavigationController(rootViewController: FeedViewController())
            return Module(moduleType: moduleType, viewModel: viewModel, viewController: viewController)
        case .profile:
            let viewModel = LoginViewModel(loginInspector: loginInspetor)
            let viewController = UINavigationController(rootViewController: LoginViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, viewController: viewController)
        }
    }
}
    
