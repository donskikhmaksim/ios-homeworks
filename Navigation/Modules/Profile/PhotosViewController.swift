//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Максим Донских on 02.11.2022.
//

import UIKit
import iOSIntPackage
import Dispatch

class PhotosViewController: UIViewController {
    
    var newImages: [UIImage?] = []
    private var imageProcessor = ImageProcessor()
    
    private lazy var myImages: [UIImage] = {
        images.map({ $0! })
    }()
    
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
    
    override func loadView() {
        super.loadView()
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.title = "Photo Gallery"
        processImages(imageArray: myImages)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSetup()
    }
    
    private func navigationSetup() {
        navigationItem.title = "Photo Gallery"
        navigationController?.navigationBar.backgroundColor = .systemGray5
        navigationController?.navigationBar.alpha = 1
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray5
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func processImages(imageArray: [UIImage]) {
        
        let startTime = DispatchTime.now()
        var endTime = DispatchTime.now()
        
        // userInteractive - 7
        // userInitiated - 7
        // utility - 12
        // background - 35
        
        
        imageProcessor.processImagesOnThread(sourceImages: imageArray,
                                             filter: .noir,
                                             qos: .background) { [weak self] in
            self?.newImages = $0.map({ UIImage(cgImage: $0!) })
            endTime = DispatchTime.now()
            print((Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds))/1000000000, "seconds")
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom", for: indexPath) as? PhotosCollectionViewCell else {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
            return item
        }
        
        if !newImages.isEmpty {
            let viewModel = newImages[indexPath.row] ?? myImages[indexPath.row]
            item.setup(with: viewModel)
        } else {
            let viewModel = myImages[indexPath.row]
            item.setup(with: viewModel)
        }
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
