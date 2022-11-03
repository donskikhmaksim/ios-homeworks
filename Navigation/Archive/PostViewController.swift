//
//  PostViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Вперед", style: .done, target: self, action: #selector(didTapButton))
    }
    
    @objc private func didTapButton() {
        let viewController = InfoViewController()
        self.present(viewController, animated: true)

    }
    
    
}
