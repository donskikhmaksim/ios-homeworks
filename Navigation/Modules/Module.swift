//
//  Module.swift
//  Navigation
//
//  Created by Максим Донских on 30.12.2022.
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    
    enum ModuleType {
        case feed
        case profile
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let viewController: UIViewController
}

extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .feed:
            return UITabBarItem(title: "Новости", image: .add, tag: 0)
        case .profile:
            return UITabBarItem(title: "Профиль", image: .checkmark, tag: 1)
        }
    }
}
