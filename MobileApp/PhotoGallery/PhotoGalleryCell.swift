//
//  PhotoGalleryCell.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 24.04.2023.
//

import UIKit

final class PhotoGalleryCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePhotoGalleryCell(url: URL) {
        imageView.loadImage(with: url)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
