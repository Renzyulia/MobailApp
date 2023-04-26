//
//  DataSourse.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

final class DataSource: NSObject, UICollectionViewDataSource {
    let photoGalleryModel: PhotoGalleryModel
    let reuseIdentifier = "Cell"
    
    init(photoGalleryModel: PhotoGalleryModel) {
        self.photoGalleryModel = photoGalleryModel
    }
    
    // MARK: - Public methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoGalleryModel.countPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoGalleryCell
        
        cell.configurePhotoGalleryCell(url: photoGalleryModel.url[indexPath.item])
        
        return cell
    }
}
