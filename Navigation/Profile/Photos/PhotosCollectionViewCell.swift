//
//  PreviewCollectionViewCell.swift
//  Navigation
//
//  Created by Максим Донских on 03.11.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
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
