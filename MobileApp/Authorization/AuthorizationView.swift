//
//  AuthorizationView.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 21.04.2023.
//

import UIKit

final class AuthorizationView: UIView {
    weak var delegate: AuthorizationViewDelegate?
    
    private let textLabel = UILabel()
    private let loginButton = LoginButton()
    
    init() {
        super.init(frame: .zero)
        configureTextLabel()
        configureLoginButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextLabel() {
        textLabel.text = "Mobile Up Gallery"
        textLabel.textColor = .black
        textLabel.textAlignment = .left
        textLabel.font = .systemFont(ofSize: 48, weight: .bold)
        textLabel.numberOfLines = 2
        
        addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 170),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            textLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -50)
        ])
    }
    
    private func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(loginTap), for: .touchUpInside)
        
        addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42),
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
    
    @objc private func loginTap() {
        delegate?.login()
    }
}

final class LoginButton: UIControl {
    private let label = UILabel()
    
    init() {
        super.init(frame: .zero)
        configureLoginButton()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLoginButton() {
        backgroundColor = .black
        layer.masksToBounds = true
        layer.cornerRadius = 13
    }
    
    private func configureLabel() {
        label.text = "Вход через VK"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
