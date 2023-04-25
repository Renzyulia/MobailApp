//
//  ViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 21.04.2023.
//

import UIKit

class ControlZoneViewController: UIViewController, ControlZoneModelDelegate, AuthorizationViewControllerDelegate, PhotoGalleryViewControllerDelegate {
    private var controlZoneModel: ControlZoneModel? = nil
    private var authorizationViewController: AuthorizationViewController? = nil
    private var photoGalleryViewController: PhotoGalleryViewController? = nil
    private var navigationPhotoGalleryViewController: UINavigationController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controlZoneModel = ControlZoneModel()
        self.controlZoneModel = controlZoneModel
        
        controlZoneModel.delegate = self
        
        controlZoneModel.viewDidLoad()
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
        self.navigationPhotoGalleryViewController = navigationPhotoGalleryViewController
        
        embed(navigationPhotoGalleryViewController)
    }
    
    func userDidAuthorizeSuccessfully() {
        authorizationViewController?.remove()
        controlZoneModel?.userDidAuthorizeSuccessfully()
    }
    
    func didTapExit() {
        navigationPhotoGalleryViewController?.remove()
        controlZoneModel?.didTapExit()
    }
}

