//
//  ViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 21.04.2023.
//

import UIKit

class ViewController: UIViewController, RootModelDelegate, AuthorizationViewControllerDelegate, PhotoGalleryViewControllerDelegate {
    private var rootModel: RootModel? = nil
    private var authorizationViewController: AuthorizationViewController? = nil
    private var photoGalleryViewController: PhotoGalleryViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootModel = RootModel()
        self.rootModel = rootModel
        
        rootModel.delegate = self
        
        rootModel.viewDidLoad()
    }
    
    func showAuthorization() {
        let authorizationViewController = AuthorizationViewController()
        self.authorizationViewController = authorizationViewController
        authorizationViewController.delegate = self
        
        embed(authorizationViewController)
    }
    
    func showUserProfile(token: String) {
        let photoGalleryViewController = PhotoGalleryViewController(token: token)
        self.photoGalleryViewController = photoGalleryViewController
        photoGalleryViewController.delegate = self
        
        let navigationPhotoGalleryViewController = UINavigationController(rootViewController: photoGalleryViewController)
        
        embed(navigationPhotoGalleryViewController)
    }
    
    func userDidAuthorizeSuccessfully() {
        authorizationViewController?.remove()
        rootModel?.userDidAuthorizeSuccessfully()
    }
    
    func didTapExit() {
        photoGalleryViewController?.remove()
        rootModel?.didTapExit()
    }
}

