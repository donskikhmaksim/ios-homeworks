//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Максим Донских on 29.10.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "avatar")
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Petrov Ivan"
        label.font = UIFont.italicSystemFont(ofSize: 16.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Crazy Frog"
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var mindsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "There are my crazy minds"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSizeMake(4, 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        button.setTitle("Everything is complicated", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
//        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2
        self.addSubview(nickNameLabel)
        self.addSubview(mindsLabel)
        self.addSubview(fullNameLabel)
        self.addSubview(statusButton)
        
        let avatareImageViewAnchors = avatareImageViewAnchors()
        let nickNameLabelAnchors = nickNameLabelAnchors()
        let mindsLabelAnchors = mindsLabelAnchors()
        let statusButtonAnchors = statusButtonAnchors()
        let fullNameLabelAnchors = fullNameLabelAnchors()
        
        NSLayoutConstraint.activate(
            avatareImageViewAnchors +
            nickNameLabelAnchors +
            mindsLabelAnchors +
            statusButtonAnchors +
            fullNameLabelAnchors
        )
        
        
    }
    
    private func avatareImageViewAnchors() -> [NSLayoutConstraint] {
        let topAnchor = self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingAnchor = self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let widthAnchor = self.avatarImageView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.3)
        let heightAnchor = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor)
        
        return [
            topAnchor, leadingAnchor, widthAnchor, heightAnchor
        ]
    }
    
    private func nickNameLabelAnchors() -> [NSLayoutConstraint] {
        let topAnchor = self.nickNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let centerXAnchor = self.nickNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        return [
            topAnchor, centerXAnchor
        ]
    }
    
    private func mindsLabelAnchors() -> [NSLayoutConstraint] {
        let bottomAnchor = self.mindsLabel.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -34)
        let leadingAnchor = self.mindsLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.centerXAnchor)
        let trailingAnchor = self.mindsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        return [
            bottomAnchor, leadingAnchor, trailingAnchor
        ]
    }
    
    private func fullNameLabelAnchors() -> [NSLayoutConstraint] {
        let topAnchor = self.fullNameLabel.topAnchor.constraint(equalTo: self.nickNameLabel.topAnchor)
        let bottomAnchor = self.fullNameLabel.bottomAnchor.constraint(equalTo: self.mindsLabel.bottomAnchor)
        let centerXAnchor = self.fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        return [
            topAnchor, bottomAnchor, centerXAnchor
        ]
    }
    
    private func statusButtonAnchors() -> [NSLayoutConstraint] {
        let topAnchor = self.statusButton.topAnchor.constraint(greaterThanOrEqualTo: self.avatarImageView.bottomAnchor, constant: 16)
        let leadingAnchor = self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingAnchor = self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightAnchor = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        let bottomAnchor = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -16)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, heightAnchor, bottomAnchor
        ]
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            print(buttonTitle)
        }
    }
    
}
