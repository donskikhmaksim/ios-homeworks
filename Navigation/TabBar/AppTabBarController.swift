//
//  AppTabBar.swift
//  Navigation
//
//  Created by Максим Донских on 30.12.2022.
//

import UIKit

final class AppTapBarController: UITabBarController {
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
