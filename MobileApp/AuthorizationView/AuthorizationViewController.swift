//
//  AuthorizationViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 21.04.2023.
//

import UIKit

final class AuthorizationViewController: UIViewController, AuthorizationViewDelegate {
    
    private var authorizationView: AuthorizationView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorizationView = AuthorizationView()
        self.authorizationView = authorizationView
        authorizationView.delegate = self
        
        view.addSubview(authorizationView)
        
        authorizationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationView.topAnchor.constraint(equalTo: view.topAnchor),
            authorizationView.leftAnchor.constraint(equalTo: view.leftAnchor),
            authorizationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            authorizationView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func login() {
    }
}
