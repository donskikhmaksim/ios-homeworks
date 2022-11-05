//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Максим Донских on 02.11.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Default")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "Custom")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.navigationItem.title = "Photo Gallery"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationSetup()
    }
    
    private func navigationSetup() {
        self.navigationItem.title = "Photo Gallery"
        self.navigationController?.navigationBar.backgroundColor = .systemGray5
        self.navigationController?.navigationBar.alpha = 1
        
        
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemGray5
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom", for: indexPath) as? PhotosCollectionViewCell else {
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
                return item
            }
        let viewModel = images[indexPath.row]
        item.setup(with: viewModel)
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interitemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        
        let width = collectionView.bounds.width - (2 * interitemSpacing) - insets.left - insets.right
        let itemWidtg = floor(width / 3)
        
        return CGSize(width: itemWidtg, height: itemWidtg)
    }
}
