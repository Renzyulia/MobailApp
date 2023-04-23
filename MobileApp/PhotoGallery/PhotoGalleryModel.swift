//
//  PhotoGalleryView.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

final class PhotoGalleryModel {
    weak var delegate: PhotoGalleryModelDelegate?
    
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func didTapExit() {
        TokenStorage.shared.delete(token: token)
        delegate?.dismiss()
    }
    
}
