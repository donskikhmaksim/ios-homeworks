//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Максим Донских on 01.11.2022.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mindsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusButton: CustomButton = {
        let button = CustomButton(title: "Tap to change status", titleColor: .white, backgroundColor: .systemBlue)
        button.layer.shadowOffset = CGSizeMake(4, 4)
        button.layer.shadowRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        button.closure = { self.buttonDidTap(self.statusButton) }
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    private func setupView() {
        addSubview(avatarImageView)
        addSubview(nickNameLabel)
        addSubview(mindsLabel)
        addSubview(statusButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.25),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1.0),
            
            nickNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            nickNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mindsLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            mindsLabel.leadingAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            mindsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            statusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            statusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -16),
        ])
    }
    
    func setup(login : String, status : String, avatar : UIImage) {
        nickNameLabel.text = login
        mindsLabel.text = status
        avatarImageView.image = avatar
        
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            print(buttonTitle)
        }
    }
    
    
    
}
