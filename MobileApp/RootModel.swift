//
//  RootModel.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

final class RootModel {
    weak var delegate: RootModelDelegate?
    
    func viewDidLoad() {
        if let token = TokenStorage.shared.getToken() {
            delegate?.showUserProfile(token: token)
        } else {
            delegate?.showAuthorization()
        }
    }
    
    func userDidAuthorizeSuccessfully() {
        if let token = TokenStorage.shared.getToken() {
            delegate?.showUserProfile(token: token)
        } else {
            print("error")
        }
    }
    
    func didTapExit() {
        delegate?.showAuthorization()
    }
}
