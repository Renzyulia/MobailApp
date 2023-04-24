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
    
    private var dataSource: DataSource? = nil
    private var collectionView: UICollectionView!
    private var photoGalleryModel: PhotoGalleryModel? = nil
    
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let photoGalleryModel = PhotoGalleryModel(token: token)
        self.photoGalleryModel = photoGalleryModel
        photoGalleryModel.delegate = self
        
        configureNavigationBar()
        
        let dataSource = DataSource(token: token)
        self.dataSource = dataSource
        
        dataSource.getData()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: view.bounds.width / 2 - 1, height: view.bounds.width / 2 - 1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
        
        view.addSubview(collectionView)
    }
    
    func dismiss() {
        delegate?.didTapExit()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "MobileUp Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(didTapExit))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc private func didTapExit() {
        photoGalleryModel?.didTapExit()
    }
}
