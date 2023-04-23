//
//  ViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 21.04.2023.
//

import UIKit

class ViewController: UIViewController, RootModelDelegate, AuthorizationViewControllerDelegate {
    private var rootModel: RootModel? = nil
    private var authorizationViewController: AuthorizationViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootModel = RootModel()
        self.rootModel = rootModel
        
        rootModel.delegate = self
        
        rootModel.viewDidLoad()
        print("didLoad")
    }
    
    func showAuthorization() {
        let authorizationViewController = AuthorizationViewController()
        self.authorizationViewController = authorizationViewController
        authorizationViewController.delegate = self
        
        embed(authorizationViewController)
    }
    
    func showUserProfile(token: String) {
//        TokenStorage.shared.delete(token: token)
        print("token")
        //создаем навигейшн контроллер
        //создаем контроллер экрана профиля и добавляем его в показ
    }
    
    func userDidAuthorizeSuccessfully() {
        authorizationViewController?.remove()
        print("removeAuthorization")
        rootModel?.userDidAuthorizeSuccessfully()
    }
}

