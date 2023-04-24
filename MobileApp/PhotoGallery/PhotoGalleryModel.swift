//
//  PhotoGalleryView.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 23.04.2023.
//

import UIKit

final class PhotoGalleryModel {
    weak var delegate: PhotoGalleryModelDelegate?
    
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func didTapExit() {
        TokenStorage.shared.delete(token: token)
        delegate?.dismiss()
    }
    
    private func getData() {
        let url = "https://api.vk.com/method/photos.get?owner_id=-128666765&album_id=266310117&access_token="
        let request = URLRequest(url: URL(string: url + token + "&v=5.131")!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error -> Void in
          do {
            let jsonDecoder = JSONDecoder()
            let responseModel = try jsonDecoder.decode(Model.self, from: data!)
            
            DispatchQueue.main.async {
                print(responseModel.response.count)
                print(responseModel.response.items[0].sizes[0].url)
            }
          } catch {
              print("JSON Serialization error")
              print(error)
            }
        }).resume()
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
    let url: URL
}
