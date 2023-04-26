//
//  OAuthViewController.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 22.04.2023.
//

import UIKit
import WebKit

final class OAuthViewController: UIViewController, OAuthModelDelegate, WKNavigationDelegate {
    weak var delegate: OAuthViewControllerDelagate?
    
    private let webView = WKWebView()
    private var oAuthModel: OAuthModel? = nil
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oAuthModel = OAuthModel()
        self.oAuthModel = oAuthModel
        
        oAuthModel.delegate = self
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        oAuthModel.viewDidLoad()
    }
    
    func showPage(at url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if ((webView.url?.absoluteString.range(of: "access_token")) != nil) {
            oAuthModel?.didReceiveRedirectUrl(webView.url!)
        } else {
            print("error!")
        }
    }
    
    func dismissWith(result: Result) {
        switch result {
        case .success: delegate?.userDidAuthorizeSuccessfully() 
        case .error: delegate?.didAuthorizeError()
        }
    }
}
