//
//  PreviewCollectionDataSource.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 25.04.2023.
//

import UIKit

final class PreviewCollectionDataSource: NSObject, UICollectionViewDataSource {
    let reuseIdentifier = "Cell"
    
    private let PhotoModel: PhotoModel
    
    init(PhotoModel: PhotoModel) {
        self.PhotoModel = PhotoModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = .green
        
        return cell
    }
}
