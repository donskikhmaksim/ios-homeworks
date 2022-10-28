//
//  FeedViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var showPostButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 350, height: 75))
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBrown
        
        self.view.addSubview(showPostButton)
        self.showPostButton.center = self.view.center
    
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
    }
    
    @objc private func didTapButton() {
        let viewController = PostViewController()
        viewController.title = self.firstPost.title
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

    let firstPost = Post(title: "First post")
    
}


