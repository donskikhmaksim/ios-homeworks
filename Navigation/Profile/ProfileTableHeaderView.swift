//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Максим Донских on 01.11.2022.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        self.addSubview(profileHeaderView)
        
        NSLayoutConstraint.activate([
        self.profileHeaderView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
        self.profileHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        self.profileHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        self.profileHeaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        self.profileHeaderView.heightAnchor.constraint(lessThanOrEqualToConstant: 250)
        ])
    }
    
    
    
}
