//
//  OAuthModelDelegate.swift
//  MobileApp
//
//  Created by Yulia Ignateva on 22.04.2023.
//

import UIKit

protocol OAuthModelDelegate: AnyObject {
    func showPage(at: URL)
    func dismissWith(result: Result)
}
