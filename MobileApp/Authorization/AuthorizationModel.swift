//
//  AuthorizationModel.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 22.04.2023.
//

import UIKit

final class AuthorizationModel {
    weak var delegate: AuthorizationModelDelegate?
    
    func didTapLogin() {
        delegate?.openOAuthView()
    }
    
    func didAuthorizeError() {
        delegate?.showAuthorizeError()
    }
}
