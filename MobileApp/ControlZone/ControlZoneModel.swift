//
//  RootModel.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

final class ControlZoneModel {
    weak var delegate: ControlZoneModelDelegate?
    
    // MARK: - Public methods
    
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
            delegate?.showAuthorization()
            assertionFailure("Token is missing")
        }
    }
    
    func didTapExit() {
        delegate?.showAuthorization()
    }
}
