//
//  PhotoGalleryViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

final class PhotoGalleryViewController: UIViewController, UICollectionViewDelegate, PhotoGalleryModelDelegate {
    let token: String
    weak var delegate: PhotoGalleryViewControllerDelegate?
    
    private var photoGalleryDataSource: PhotoGalleryDataSource? = nil
    private var collectionView: UICollectionView!
    private var photoGalleryModel: PhotoGalleryModel? = nil
    private var photoViewController: PhotoViewController? = nil
    
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let photoGalleryModel = PhotoGalleryModel(token: token)
        self.photoGalleryModel = photoGalleryModel
        photoGalleryModel.delegate = self
        
        configureNavigationBar()

        photoGalleryModel.viewDidLoad(width: Int(view.bounds.width))
    }
    
    func showPhotoGalleryView() {
        let photoGalleryDataSource = PhotoGalleryDataSource(photoGalleryModel: photoGalleryModel!)
        self.photoGalleryDataSource = photoGalleryDataSource
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width / 2 - 1, height: view.bounds.width / 2 - 1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = photoGalleryDataSource
        collectionView.register(PhotoGalleryCell.self, forCellWithReuseIdentifier: photoGalleryDataSource.reuseIdentifier)
        
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoGalleryModel?.didSelectItem(indexPath.item)
    }
    
    func showPhoto(item: Int) {
        let photoViewController = PhotoViewController(token: token, item: item)
        self.photoViewController = photoViewController
        
        navigationController?.pushViewController(photoViewController, animated: false)
    }
    
    func showLoadingError() {
        let alert = UIAlertController(title: nil, message: "Ошибка загрузки фотографий", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func dismiss() {
        delegate?.didTapExit()
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar() {
        navigationItem.title = "MobileUp Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(didTapExit))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton
        
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @objc private func didTapExit() {
        photoGalleryModel?.didTapExit()
    }
}
