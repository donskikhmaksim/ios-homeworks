//
//  PreviewCollectionViewCell.swift
//  Navigation
//
//  Created by Максим Донских on 03.11.2022.
//

import UIKit

class PreviewCollectionViewCell: UICollectionViewCell {
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    private func setupView() {
        self.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            self.photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setup(with image: UIImage?) {
        self.photoImageView.image = image
    }
    
}
