//
//  FeedViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    //    private lazy var showPostButton: UIButton = {
    //        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 350, height: 75))
    //        button.backgroundColor = .systemYellow
    //        button.layer.cornerRadius = 15
    //        button.layer.masksToBounds = true
    //        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    //
    //        return button
    //    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBrown
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            self.navigationController?.navigationBar.isTranslucent = true  // pass "true" for fixing iOS 15.0 black bg issue
            self.navigationController?.navigationBar.tintColor = UIColor.clear // We need to set tintcolor for iOS 15.0
            appearance.shadowColor = .clear    //removing navigationbar 1 px bottom border.
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        //        self.view.addSubview(showPostButton)
        //        self.showPostButton.center = self.view.center
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
    }
    
    //    @objc private func didTapButton() {
    //        let viewController = PostViewController()
    //        viewController.title = self.firstPost.title
    //        self.navigationController?.pushViewController(viewController, animated: true)
    //
    //    }
}


