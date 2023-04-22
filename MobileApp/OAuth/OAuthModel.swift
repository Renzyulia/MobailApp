//
//  OAuthModel.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 22.04.2023.
//

import UIKit

final class OAuthModel {
    weak var delegate: OAuthModelDelegate?
    
    private let urlRequest = URL(string: "https://oauth.vk.com/authorize?client_id=51622196&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=4&response_type=token&v=5.131")
    
    func viewDidLoad() {
        delegate?.showPage(at: urlRequest!)
    }
    
    func didReceiveRedirectUrl(_ url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryItems = components?.queryItems {
            for queryItem in queryItems {
                if queryItem.name == "authorize_url" {
                    guard queryItem.value != nil else { return }
                    if let url = URL(string: queryItem.value!.removingPercentEncoding!) {
                        let component = URLComponents(url: url, resolvingAgainstBaseURL: false)
                        if let fragment = component?.fragment {
                            let token = String(fragment.dropFirst(13))
                            print(token)
                        }
                    }
                } else {
                    print("Error")
                }
            }
        }
    }
}
