//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Максим Донских on 02.11.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    lazy var photosPreviewCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Default")
        collectionView.register(PreviewCollectionViewCell.self, forCellWithReuseIdentifier: "Custom")
//        collectionView.backgroundColor = .systemGray5
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "arrow.right")
        imageview.tintColor = .black
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .systemBackground
        self.addSubview(headerLabel)
        self.addSubview(photosPreviewCollectionView)
        self.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            self.photosPreviewCollectionView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 12),
            self.photosPreviewCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.photosPreviewCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.photosPreviewCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            self.photosPreviewCollectionView.widthAnchor.constraint(equalToConstant: self.frame.width - 24),
            
            self.arrowImage.centerYAnchor.constraint(equalTo: self.headerLabel.centerYAnchor),
            self.arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            self.arrowImage.widthAnchor.constraint(equalToConstant: 30),
            self.arrowImage.heightAnchor.constraint(equalToConstant: 30),
            
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 160)
        ])
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom", for: indexPath) as? PreviewCollectionViewCell else {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
            return item
        }
        
        let viewModel = images[indexPath.row]
        item.layer.cornerRadius = 6
        item.layer.masksToBounds = true
        item.setup(with: viewModel)
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interitemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        
        let width = collectionView.bounds.width - 3 * interitemSpacing - insets.left - insets.right
        let itemWidtg: CGFloat = width / 4
        
        return CGSize(width: itemWidtg, height: itemWidtg)
    }
    
}
