//
//  PhotoViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 25.04.2023.
//

import UIKit

final class PhotoViewController: UIViewController, UICollectionViewDelegate, PhotoModelDelegate {
    private let token: String
    private let item: Int
    private var photoModel: PhotoModel? = nil
    private var photoView: PhotoView? = nil
    private var previewCollectionDataSource: PreviewCollectionDataSource? = nil
    
    init(token: String, item: Int) {
        self.token = token
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
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
    
    func showLoadingPhotoError() {
        let alert = UIAlertController(title: nil, message: "Ошибка загрузки фотографий", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showShareMenu() {
        let items:[Any] = [photoView!.photoView.image!]
        
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [.assignToContact, .airDrop, .addToReadingList, .print, .copyToPasteboard]
        
        activityViewController.completionWithItemsHandler = { [weak self] (activityType: UIActivity.ActivityType?, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self!.photoModel?.photoSavedSuccessfully()
                return
            } else {
                print("cancel")
            }
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
                self!.photoModel?.photoSavingError()
            }
        }
        present(activityViewController, animated: true)
    }
    
    func showSuccessfulSaving() {
        let alert = UIAlertController(title: nil, message: "Фотография загружена", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSavingError() {
        let alert = UIAlertController(title: nil, message: "Ошибка загрузки фотографии", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Private methods
    
    private func configureNavigationBar(date: String) {
        navigationItem.title = "\(date)"
        
        let shareButton = UIBarButtonItem(image: UIImage(named: "SaveIcon"), style: .plain, target: self, action: #selector(didTapShareButton))
        shareButton.tintColor = .black
        navigationItem.rightBarButtonItem = shareButton
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func didTapShareButton() {
        photoModel?.didTapShareButton()
    }
    
    private func configurePhotoView(url: URL) {
        let photoView = PhotoView(previewCollectionDataSource: previewCollectionDataSource!,
                                  previewCollectionDelegate: self,
                                  reuseIdentifier: previewCollectionDataSource!.reuseIdentifier,
                                  photoUrl: url)
        
        self.photoView = photoView
        
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
