//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Максим Донских on 29.10.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 130, width: 120, height: 120))
        imageView.image = UIImage(named: "avatar")
//        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        
        return imageView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 130, width: 200, height: 50))
        label.text = "Crazy Frog"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        
        return label
    }()
    
    private lazy var mindsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 180, width: 200, height: 50))
        label.text = "There are my crazy minds"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 280, width: 390, height: 50))
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        button.setTitle("Everything is complicated", for: .normal)
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(avatarImageView)
        self.addSubview(nickNameLabel)
        self.addSubview(mindsLabel)
        self.addSubview(statusButton)
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            print(buttonTitle)
        }
    }
    
}
