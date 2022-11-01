//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        var view = ProfileHeaderView(frame: .zero)
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var unknownButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Unknown button, think twice before tap", for: .normal)
        button.setTitle("Ha-Ha! Now you're Philip Kirkorov!", for: .highlighted)
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
       
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.navigationItem.title = "Профиль"
        self.view.addSubview(profileHeaderView)
        self.view.addSubview(unknownButton)
        
        NSLayoutConstraint.activate([
            self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.profileHeaderView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220),
            self.profileHeaderView.bottomAnchor.constraint(lessThanOrEqualTo: self.unknownButton.topAnchor, constant: -10),
            
            self.unknownButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.unknownButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.unknownButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.unknownButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
