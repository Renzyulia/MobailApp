//
//  OAuthViewControllerDelegate.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 22.04.2023.
//

import UIKit

protocol OAuthViewControllerDelagate: AnyObject {
    func userDidAuthorizeSuccessfully()
    func didAuthorizeError()
    func userDidCancel()
}
