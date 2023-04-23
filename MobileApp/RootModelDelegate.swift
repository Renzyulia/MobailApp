//
//  RootModelDelegate.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

protocol RootModelDelegate: AnyObject {
    func showAuthorization()
    func showUserProfile(token: String)
}
