//
//  PhotoGalleryCell.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 24.04.2023.
//

import UIKit

final class PhotoGalleryCell: UICollectionViewCell {
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
