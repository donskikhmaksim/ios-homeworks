//
//  PostViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    private var coordinator: FeedCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Вперед", style: .done, target: self, action: #selector(didTapButton))
    }
    
    init(coordinator: FeedCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        coordinator?.presentInfoVC()
    }
}
