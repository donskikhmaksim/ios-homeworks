//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Максим Донских on 29.10.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 16, width: 120, height: 120))
        imageView.image = UIImage(named: "avatar")
//        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        
        return imageView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 157, y: 27, width: 150, height: 30))
        label.text = "Crazy Frog"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        
        return label
    }()
    
    private lazy var mindsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 170, y: 84, width: 150, height: 30))
        label.text = "There are my crazy minds"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 148, width: 382, height: 50))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSizeMake(4, 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        button.setTitle("Everything is complicated", for: .normal)
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function)
        self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(avatarImageView)
        self.addSubview(nickNameLabel)
        self.nickNameLabel.center.x = self.center.x
        self.addSubview(mindsLabel)
        self.addSubview(statusButton)
        print(#function)
        
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            print(buttonTitle)
            print(#function)
        }
    }
    
}
