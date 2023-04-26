//
//  PhotoView.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 25.04.2023.
//

import UIKit

final class PhotoView: UIView {
    let previewCollectionDataSource: UICollectionViewDataSource
    let previewCollectionDelegate: UICollectionViewDelegate
    let reuseIdentifier: String
    let photoUrl: URL
    let photoView = UIImageView()
    
    private var previewCollectionView: UICollectionView!
    
    init(previewCollectionDataSource: UICollectionViewDataSource, previewCollectionDelegate: UICollectionViewDelegate, reuseIdentifier: String, photoUrl: URL) {
        self.previewCollectionDataSource = previewCollectionDataSource
        self.previewCollectionDelegate = previewCollectionDelegate
        self.reuseIdentifier = reuseIdentifier
        self.photoUrl = photoUrl
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        configurePreviewCollectionView()
        configurePhotoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func configurePreviewCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 1

        previewCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        previewCollectionView.delegate = previewCollectionDelegate
        previewCollectionView.dataSource = previewCollectionDataSource
        previewCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        addSubview(previewCollectionView)

        previewCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewCollectionView.heightAnchor.constraint(equalToConstant: 60),
            previewCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            previewCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            previewCollectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func configurePhotoView() {
        photoView.loadImage(with: photoUrl)
        photoView.backgroundColor = .white
        photoView.contentMode = .scaleAspectFit
        photoView.clipsToBounds = true
        
        addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            photoView.leftAnchor.constraint(equalTo: leftAnchor),
            photoView.rightAnchor.constraint(equalTo: rightAnchor),
            photoView.bottomAnchor.constraint(equalTo: previewCollectionView.topAnchor, constant: -7)
        ])
    }
}
