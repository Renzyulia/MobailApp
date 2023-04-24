//
//  PhotoGalleryView.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

final class PhotoGalleryModel {
    weak var delegate: PhotoGalleryModelDelegate?
    var countPhotos: Int = 0
    var url = [URL]()
    
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func viewDidLoad(width: Int) {
        getData(forViewWithWidth: width)
    }
    
    func didTapExit() {
        TokenStorage.shared.delete(token: token)
        delegate?.dismiss()
    }
    
    private func getData(forViewWithWidth: Int) {
        let url = "https://api.vk.com/method/photos.get?owner_id=-128666765&album_id=266310117&access_token="
        let request = URLRequest(url: URL(string: url + token + "&v=5.131")!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Model.self, from: data!)
                
                DispatchQueue.main.async {
                    self!.countPhotos = responseModel.response.count
                    
                    for item in responseModel.response.items {
                        let index = self?.findSize(forViewWithWidth: forViewWithWidth, sizes: item.sizes)
                        guard index != nil else { return }
                        self!.url.append(item.sizes[index!].url)
                    }
                    self!.delegate?.showPhotoGalleryView()
                }
            } catch {
                print("JSON Serialization error")
                print(error)
            }
        }).resume()
    }
    
    private func findSize(forViewWithWidth: Int, sizes: [Sizes]) -> Int {
        var minimumSize = 5000
        var index = 0

        for size in 0..<sizes.count {
            if sizes[size].width >= forViewWithWidth && sizes[size].width <= minimumSize {
                minimumSize = sizes[size].width
                index = size
            } else if sizes[size].height >= forViewWithWidth && sizes[size].height <= minimumSize {
                minimumSize = sizes[size].height
                index = size
            }
        }
        return index
    }
}

struct Model: Decodable {
    let response: Response
}

struct Response: Decodable {
    let count: Int
    let items: [Items]
}

struct Items: Decodable {
    let date: Int
    let sizes: [Sizes]
}

struct Sizes: Decodable {
    let height: Int
    let url: URL
    let width: Int
}
