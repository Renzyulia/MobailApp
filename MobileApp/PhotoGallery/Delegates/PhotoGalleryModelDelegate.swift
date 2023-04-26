//
//  PhotoGalleryModelDelegate.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

protocol PhotoGalleryModelDelegate: AnyObject {
    func showPhotoGalleryView()
    func showLoadingPhotoError()
    func showPhoto(item: Int)
    func dismiss() 
}
