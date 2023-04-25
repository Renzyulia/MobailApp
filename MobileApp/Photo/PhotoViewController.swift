//
//  PhotoViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 25.04.2023.
//

import UIKit

final class PhotoViewController: UIViewController, UICollectionViewDelegate, PhotoModelDelegate, PhotoViewDelegate {
    weak var delegate: PhotoViewControllerDelegate?
    
    private let token: String
    private let item: Int
    private var photoModel: PhotoModel? = nil
    private var previewCollectionDataSource: PreviewCollectionDataSource? = nil
    
    init(token: String, item: Int) {
        self.token = token
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoModel = PhotoModel(token: token)
        self.photoModel = photoModel
        photoModel.delegate = self
        
        let previewCollectionDataSource = PreviewCollectionDataSource(PhotoModel: photoModel)
        self.previewCollectionDataSource = previewCollectionDataSource
        
        photoModel.viewDidLoad(for: item)
    }
    
    func showPhotoView() {
        guard let url = photoModel?.urlPhoto, let date = photoModel?.datePhoto else { return }
        configureNavigationBar(date: date)
        configurePhotoView(url: url)
    }
    
    private func configureNavigationBar(date: String) {
        navigationItem.title = "\(date)"
        
        let exitButton = UIBarButtonItem(image: UIImage(named: "SaveIcon"), style: .plain, target: self, action: #selector(didTapExit))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func didTapExit() {
        print("tapped left button")
    }
    
    private func configurePhotoView(url: URL) {
        let photoView = PhotoView(previewCollectionDataSource: previewCollectionDataSource!,
                                  previewCollectionDelegate: self,
                                  reuseIdentifier: previewCollectionDataSource!.reuseIdentifier,
                                  photoUrl: url)
        
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
