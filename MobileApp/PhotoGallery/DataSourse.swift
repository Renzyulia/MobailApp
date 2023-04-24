//
//  DataSourse.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

final class DataSource: NSObject, UICollectionViewDataSource {
    let token: String
    var count: Int = 0
    
    let reuseIdentifier = "Cell"
    private let items = ["1","2","3","4"] //просим у модели все загруженные фотографии
    
    init(token: String) {
        self.token = token
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = .green
        
        let image = UIImageView()
        cell.contentView.addSubview(image)
        
        return cell
    }
    
    
}
