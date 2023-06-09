//
//  PhotoGalleryModelDelegate.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

protocol PhotoGalleryModelDelegate: AnyObject {
    func showPhotoGalleryView()
    func showPhoto(item: Int)
    func showLoadingError()
    func dismiss() 
}
