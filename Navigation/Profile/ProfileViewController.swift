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
        
        let profileViewControllerAnchors = profileViewControllerAnchors()
        let unknownButtonAnchors = unknownButtonAnchors()
        
        
        NSLayoutConstraint.activate(
            profileViewControllerAnchors +
            unknownButtonAnchors
        )

    }
    
    private func profileViewControllerAnchors() -> [NSLayoutConstraint] {
        let topAnchor = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let heightAnchor = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, heightAnchor
        ]
    }
    
    private func unknownButtonAnchors() -> [NSLayoutConstraint] {
        let leadingAnchor = self.unknownButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.unknownButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let buttonAnchor = self.unknownButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let heightAnchor = self.unknownButton.heightAnchor.constraint(equalToConstant: 50)
        
        return [
            leadingAnchor, trailingAnchor, buttonAnchor, heightAnchor
        ]
    }
    
}
