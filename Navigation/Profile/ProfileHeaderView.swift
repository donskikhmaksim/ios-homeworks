//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Максим Донских on 29.10.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "avatar")
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
        button.layer.cornerRadius = 12
        button.layer.shadowOffset = CGSizeMake(4, 4)
        button.layer.shadowRadius = 12
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height / 2
    }
    
    private func setupView() {
        self.addSubview(avatarImageView)
        self.addSubview(nickNameLabel)
        self.addSubview(mindsLabel)
        self.addSubview(statusButton)
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.lessThanOrEqualToSuperview().multipliedBy(0.3)
            $0.width.equalTo(avatarImageView.snp.height).multipliedBy(1.0)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.centerX.equalToSuperview()
        }
        
        mindsLabel.snp.makeConstraints {
            $0.bottom.equalTo(statusButton.snp.top).inset(34)
            $0.leading.equalTo(avatarImageView.snp.centerX)
            $0.trailing.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            print(buttonTitle)
        }
    }
    
}
