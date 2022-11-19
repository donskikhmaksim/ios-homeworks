//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Максим Донских on 01.11.2022.
//

import UIKit

protocol ProfileTableHeaderViewDelegate: AnyObject {
    
   func avatarTap()
    
}

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: ProfileTableHeaderViewDelegate?
    
    private lazy var animateView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        }()

    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "avatar")
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.isUserInteractionEnabled = true
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
    
    private lazy var decreaseAvatarButton: UIButton = {
        let button = UIButton(frame: CGRect(x: Int(UIScreen.main.bounds.width) - 20, y: Int(UIScreen.main.bounds.height / 2 - 120) - Int(UIScreen.main.bounds.width) / 2, width: 20, height: 20))
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .black
        button.alpha = 0
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(decreaseButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private var isAvatarIncreased = false
    
    private var avatarWidthConstraint: NSLayoutConstraint?
    private var avatarHeightConstraint: NSLayoutConstraint?
    private var avatarTopConstraint: NSLayoutConstraint?
    private var avatarLeadingConstraint: NSLayoutConstraint?
    
    private var mindsLabelCenter = CGPoint(x: 0, y: 0)
    private var statusButtonCenter = CGPoint(x: 0, y: 0)
    private var displayCenter = CGPoint(x: 0, y: 0)
    
    private var mindsLabelLeadingConstraint: NSLayoutConstraint?
    private var mindsLabelTrailingConstraint: NSLayoutConstraint?
    private var mindsLabelBottomConstraint: NSLayoutConstraint?
    
    private var statusButtonTopConstraint: NSLayoutConstraint?
    private var statusButtonLeadingConstraint: NSLayoutConstraint?
    private var statusButtonTrailingConstraint: NSLayoutConstraint?
    private var statusButtonGeightConstraint: NSLayoutConstraint?
    private var statusButtonBottonConstraint: NSLayoutConstraint?

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height / 2
        mindsLabelCenter = self.mindsLabel.center
        statusButtonCenter = self.statusButton.center
        displayCenter = CGPoint(x: UIScreen.main.bounds.width / 2 , y: UIScreen.main.bounds.height / 2 - 120)
        
    }
    
    private func setupView() {
        self.addSubview(nickNameLabel)
        self.addSubview(mindsLabel)
        self.addSubview(statusButton)
        self.addSubview(animateView)
        self.addSubview(avatarImageView)
        self.addSubview(decreaseAvatarButton)
        
        avatarWidthConstraint = self.avatarImageView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.3)
        avatarHeightConstraint = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        avatarTopConstraint = self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        avatarLeadingConstraint = self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        
        mindsLabelLeadingConstraint = self.mindsLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.centerXAnchor)
        mindsLabelTrailingConstraint = self.mindsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        mindsLabelBottomConstraint = self.mindsLabel.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -34)
        
        statusButtonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16)
        statusButtonLeadingConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        statusButtonTrailingConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        statusButtonGeightConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        statusButtonBottonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -16)
        
        NSLayoutConstraint.activate([
            self.animateView.topAnchor.constraint(equalTo: self.topAnchor),
            self.animateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.animateView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            self.animateView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            
            self.nickNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.nickNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            avatarWidthConstraint,
            avatarHeightConstraint,
            avatarTopConstraint,
            avatarLeadingConstraint,
            
            mindsLabelLeadingConstraint,
            mindsLabelTrailingConstraint,
            mindsLabelBottomConstraint,
            
            statusButtonTopConstraint,
            statusButtonLeadingConstraint,
            statusButtonTrailingConstraint,
            statusButtonGeightConstraint,
            statusButtonBottonConstraint,
        ].compactMap({ $0 }))
        
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            print(buttonTitle)
        }
    }
    
    private func setupGestures() {
        let avatarImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageDidTap))
        self.avatarImageView.addGestureRecognizer(avatarImageTapGesture)
    }
    
    @objc private func imageDidTap() {
        
        layoutAvatarImage()
    }
    
    @objc private func decreaseButtonDidTap() {
        layoutAvatarImage2()
    }
    
    private func layoutAvatarImage() {
        
        if !isAvatarIncreased {
            
            mindsLabelLeadingConstraint?.isActive.toggle()
            mindsLabelTrailingConstraint?.isActive.toggle()
            mindsLabelBottomConstraint?.isActive.toggle()
            mindsLabel.translatesAutoresizingMaskIntoConstraints = true
            mindsLabel.center = mindsLabelCenter
            
            statusButtonTopConstraint?.isActive.toggle()
            statusButtonLeadingConstraint?.isActive.toggle()
            statusButtonTrailingConstraint?.isActive.toggle()
            statusButtonGeightConstraint?.isActive.toggle()
            statusButtonBottonConstraint?.isActive.toggle()
            statusButton.translatesAutoresizingMaskIntoConstraints = true
            statusButton.center = statusButtonCenter
            
            animateView.backgroundColor = .black
            
            avatarWidthConstraint?.isActive.toggle()
            avatarWidthConstraint = self.avatarImageView.widthAnchor.constraint(equalTo: self.widthAnchor)
            avatarWidthConstraint?.isActive.toggle()
            
            avatarHeightConstraint?.isActive.toggle()
            avatarHeightConstraint = self.avatarImageView.heightAnchor.constraint(equalTo: self.widthAnchor)
            avatarHeightConstraint?.isActive.toggle()
            
            avatarLeadingConstraint?.isActive.toggle()
            avatarTopConstraint?.isActive.toggle()
            
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0) {
            self.layoutIfNeeded()
            self.avatarImageView.center = self.displayCenter
            self.avatarImageView.layer.cornerRadius = 0
            self.animateView.alpha = 0.5
        } completion: { _ in
            self.isAvatarIncreased.toggle()
            self.delegate?.avatarTap()
        }
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.5) {
            self.decreaseAvatarButton.alpha = 1
        }
        
    }
    
    private func layoutAvatarImage2() {
      
        if isAvatarIncreased {
            mindsLabelLeadingConstraint?.isActive.toggle()
            mindsLabelTrailingConstraint?.isActive.toggle()
            mindsLabelBottomConstraint?.isActive.toggle()
            mindsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            statusButtonTopConstraint?.isActive.toggle()
            statusButtonLeadingConstraint?.isActive.toggle()
            statusButtonTrailingConstraint?.isActive.toggle()
            statusButtonGeightConstraint?.isActive.toggle()
            statusButtonBottonConstraint?.isActive.toggle()
            statusButton.translatesAutoresizingMaskIntoConstraints = false
            
            avatarWidthConstraint?.isActive.toggle()
            avatarWidthConstraint = self.avatarImageView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.3)
            avatarWidthConstraint?.isActive.toggle()
            
            avatarHeightConstraint?.isActive.toggle()
            avatarHeightConstraint = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
            avatarHeightConstraint?.isActive.toggle()
            
            avatarLeadingConstraint?.isActive.toggle()
            avatarTopConstraint?.isActive.toggle()
            
            mindsLabel.translatesAutoresizingMaskIntoConstraints = false
            statusButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.decreaseAvatarButton.alpha = 0
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0) {
            self.layoutIfNeeded()
            self.avatarImageView.transform = .identity
            self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height / 2
            self.animateView.alpha = 0
            
        } completion: { _ in
            self.isAvatarIncreased.toggle()
            self.delegate?.avatarTap()
        }
    }
}
