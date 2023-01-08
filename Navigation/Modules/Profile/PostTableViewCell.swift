//
//  CustomTableViewCell.swift
//  Navigation
//
//  Created by Максим Донских on 01.11.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
  
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: Post) {
        authorLabel.text = viewModel.author
        postImageView.image = UIImage(named: viewModel.image)
        descriptionLabel.text = viewModel.text
        likesCountLabel.text = "Likes: \(viewModel.likes)"
        viewsCountLabel.text = "Views: \(viewModel.views)"
    }
    
    private func setupView() {
        addSubview(authorLabel)
        addSubview(postImageView)
        addSubview(descriptionLabel)
        addSubview(likesCountLabel)
        addSubview(viewsCountLabel)
        
        // Не понял смысл этой строчки, так как любое значение убирает варнинги констрейнтов
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 1.0),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            likesCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likesCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            viewsCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            viewsCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
        
    }
    
}
