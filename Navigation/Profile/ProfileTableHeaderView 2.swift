//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Максим Донских on 01.11.2022.
//

import UIKit

class ProfileTableHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .red
//        self.addSubview(someTableView)
    }
    
    
}
