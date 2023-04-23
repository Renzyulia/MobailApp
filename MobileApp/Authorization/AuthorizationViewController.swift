//
//  AuthorizationViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 21.04.2023.
//

import UIKit

final class AuthorizationViewController: UIViewController, AuthorizationViewDelegate, AuthorizationModelDelegate, OAuthViewControllerDelagate {
    weak var delegate: AuthorizationViewControllerDelegate?
    
    private var authorizationView: AuthorizationView? = nil
    private var authorizationModel: AuthorizationModel? = nil
    private var oauthViewController: OAuthViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorizationView = AuthorizationView()
        self.authorizationView = authorizationView
        authorizationView.delegate = self
        
        let authorizationModel = AuthorizationModel()
        self.authorizationModel = authorizationModel
        authorizationModel.delegate = self
        
        view.addSubview(authorizationView)
        
        authorizationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationView.topAnchor.constraint(equalTo: view.topAnchor),
            authorizationView.leftAnchor.constraint(equalTo: view.leftAnchor),
            authorizationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            authorizationView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func didTapLogin() {
        authorizationModel?.didTapLogin()
    }
    
    func openOAuthView() {
        let oauthViewController = OAuthViewController()
        self.oauthViewController = oauthViewController
        oauthViewController.delegate = self
        
        self.embed(oauthViewController)
    }
    
    func userDidAuthorizeSuccessfully() {
        oauthViewController?.remove()
        delegate?.userDidAuthorizeSuccessfully()
    }
    
    func didAuthorizeError() {
        oauthViewController?.remove()
        //показать алерт с ошибкой
    }
}
