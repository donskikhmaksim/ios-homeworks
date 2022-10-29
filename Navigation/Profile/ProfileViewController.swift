//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        var view = ProfileHeaderView(frame: CGRect(x: 0, y: 92, width: 414, height: 715))
        view.backgroundColor = .lightGray
        print(#function)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray

        self.navigationItem.title = "Профиль"
        self.view.addSubview(profileHeaderView)
        print(#function)
        
        
    }
    
    override func viewWillLayoutSubviews() {
//        self.profileHeaderView.frame = self.view.frame
    }

}
