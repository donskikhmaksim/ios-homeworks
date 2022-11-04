//
//  CustomTableViewCell.swift
//  Navigation
//
//  Created by Максим Донских on 01.11.2022.
//

import UIKit
import StorageService
import iOSIntPackage

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
        self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: Post,_ filter: ColorFilter) {
        
        self.authorLabel.text = viewModel.author
        self.descriptionLabel.text = viewModel.text
        self.likesCountLabel.text = "Likes: \(viewModel.likes)"
        self.viewsCountLabel.text = "Views: \(viewModel.views)"
        
        ImageProcessor().processImage(sourceImage: UIImage(named: viewModel.image)  ?? UIImage(systemName: "trash")!, filter: filter) { postImageView.image = $0 }
    }
    
    private func setupView() {
        self.addSubview(self.authorLabel)
        self.addSubview(self.postImageView)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.likesCountLabel)
        self.addSubview(self.viewsCountLabel)
        
        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12),
            self.postImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.postImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.postImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            self.postImageView.heightAnchor.constraint(equalTo: self.postImageView.widthAnchor, multiplier: 1.0),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.likesCountLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.likesCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.likesCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            self.viewsCountLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.viewsCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.viewsCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }
    
}
