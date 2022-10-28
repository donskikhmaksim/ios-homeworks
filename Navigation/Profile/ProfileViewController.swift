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
        view.backgroundColor = .brown
        
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray

        self.navigationItem.title = "Профиль"
        self.view.addSubview(profileHeaderView)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        self.profileHeaderView.frame = self.view.bounds
    }

}
