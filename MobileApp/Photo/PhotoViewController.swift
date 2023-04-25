//
//  PhotoViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 25.04.2023.
//

import UIKit

final class PhotoViewController: UIViewController, UICollectionViewDelegate, PhotoModelDelegate, PhotoViewDelegate {
    weak var delegate: PhotoViewControllerDelegate?
    
    private var photoModel: PhotoModel? = nil
    private var previewCollectionDataSource: PreviewCollectionDataSource? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        let photoModel = PhotoModel()
        self.photoModel = photoModel
        photoModel.delegate = self
        
        let previewCollectionDataSource = PreviewCollectionDataSource(PhotoModel: photoModel)
        self.previewCollectionDataSource = previewCollectionDataSource
        
        configurePhotoView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Date"
        
        let exitButton = UIBarButtonItem(image: UIImage(named: "SaveIcon"), style: .plain, target: self, action: #selector(didTapExit))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func didTapExit() {
        print("tapped left button")
    }
    
    private func configurePhotoView() {
        let photoView = PhotoView(previewCollectionDataSource: previewCollectionDataSource!,
                                  previewCollectionDelegate: self,
                                  reuseIdentifier: previewCollectionDataSource!.reuseIdentifier)
        
        photoView.delegate = self
        
        view.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.topAnchor),
            photoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            photoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
