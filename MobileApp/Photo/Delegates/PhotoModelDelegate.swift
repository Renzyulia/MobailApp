//
//  PhotoModelDelegate.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 25.04.2023.
//

import UIKit

protocol PhotoModelDelegate: AnyObject {
    func showPhotoView()
    func showLoadingPhotoError()
    func showShareMenu()
    func showSuccessfulSaving()
    func showSavingError()
}
